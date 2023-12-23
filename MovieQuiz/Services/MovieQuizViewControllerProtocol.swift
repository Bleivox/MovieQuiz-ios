//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 23.12.23.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func disableButtons()
    func enableButtons()
    func deleteImageBorder()
    func imageToNil()
    func showImageBorder()
    
    func showNetworkError(message: String)
}
