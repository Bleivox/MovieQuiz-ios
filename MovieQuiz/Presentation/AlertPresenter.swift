//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 20.11.23.
//

import UIKit
 final class AlertPresenter {
    public weak var  movieQuizViewController: UIViewController?
    
    func show(quiz result: AlertModel) {
        let alert = UIAlertController(title: result.title,
                                      message: result.message,
                                      preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "GameResult"
        let action = UIAlertAction(title: result.buttonText,
                                   style: .default) {  _ in
            result.completion()
        }
        alert.addAction(action)
        movieQuizViewController?.present(alert, animated: true, completion: nil)
    }
    init(movieQuizViewController: UIViewController? = nil) {
        self.movieQuizViewController = movieQuizViewController
    }
    
}
