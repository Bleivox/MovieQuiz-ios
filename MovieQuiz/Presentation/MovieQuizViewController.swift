import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    
    // MARK: - Public Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IB Outlets
    @IBOutlet private var yesUIButton: UIButton!
    @IBOutlet private var noUIButton: UIButton!
    
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    
    @IBOutlet private var imageView: UIImageView!
    
    // MARK: - Private Properties
    private var correctAnswers = 0
    private var currentQuestionIndex = 0
    private var presenter = AlertPresenter()
    
    private let questionsAmount: Int = 10
    private lazy var questionFactory: QuestionFactoryProtocol = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    private var statisticService: StatisticService?
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = UIColor.ypBlack.cgColor
        imageView.layer.cornerRadius = 20
        questionFactory.delegate = self
        questionFactory.requestNextQuestion()
        presenter = AlertPresenter(movieQuizViewController: self)
        statisticService  = StatisticServiceImplementation()
    }
    // MARK: - QuestionFactoryDelegate
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    // MARK: - Private Methods
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)"
        )
        return questionStep
    }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.showNextQuestionOrResults()
            self.imageView.layer.borderColor = UIColor.ypBlack.cgColor
            self.yesUIButton.isEnabled = true
            self.noUIButton.isEnabled  = true
        }
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            guard let statisticService = statisticService else { return }
            statisticService.store(correct: correctAnswers, total: questionsAmount)
            let text = """
            Ваш результат: \(correctAnswers)/\(questionsAmount)
            Количество сыгранных квизов: \(statisticService.gamesCount)
            Рекорд: \(statisticService.bestGame.correct)/\(questionsAmount) \(statisticService.bestGame.date.dateTimeString)
            Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%
            """
            
            show(quiz: QuizResultsViewModel(title: "Этот раунд окончен!", text: text, buttonText: "Сыграть ещё раз"))
        } else {
            currentQuestionIndex += 1
            self.questionFactory.requestNextQuestion()
        }
    }
    
    private func show(quiz result: QuizResultsViewModel) {
        let alertModel = AlertModel(title: result.title,
                                    message: result.text,
                                    buttonText: result.buttonText,
                                    completion: {[weak self] in
            self?.currentQuestionIndex = 0
            self?.correctAnswers = 0
            self?.questionFactory.requestNextQuestion()
        })
        presenter.show(quiz: alertModel)
    }
    
//    private func answerGived(answer: Bool) {
//        let yesAnswer: Bool = true
//        let noAnswer: Bool = false
//        
//        if answer == yesAnswer {
//            guard let currentQuestion = currentQuestion else {
//                return
//            }
//            showAnswerResult(isCorrect: yesAnswer == currentQuestion.correctAnswer )
//            yesUIButton.isEnabled = false
//            noUIButton.isEnabled = false
//        } else if answer == noAnswer {
//            guard let currentQuestion = currentQuestion else {
//                return
//            }
//            showAnswerResult(isCorrect: noAnswer == currentQuestion.correctAnswer)
//            noUIButton.isEnabled = false
//            yesUIButton.isEnabled = false
//            
//        }
//    }
    private func answerGived(isCorrect: Bool) {
           guard let currentQuestion = currentQuestion else { return }
           yesUIButton.isEnabled = false
           noUIButton.isEnabled = false
           showAnswerResult(isCorrect: isCorrect == currentQuestion.correctAnswer)
       }
    
    @IBAction private func yesBottonClicked(_ sender: UIButton) {
        answerGived(isCorrect: true)
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        answerGived(isCorrect: false)
    }
    
}

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА


 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ


 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 */
