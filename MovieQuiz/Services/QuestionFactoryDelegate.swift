//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 19.11.23.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
