//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 20.11.23.
//

import UIKit
class AlertPresenter {
    public weak var  movieQuizViewController: UIViewController?
    
    func show2(quiz result: AlertModel) {
        let alert = UIAlertController(title: result.title,
                                      message: result.message,
                                      preferredStyle: .alert)
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
