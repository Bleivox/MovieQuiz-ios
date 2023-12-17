//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 19.11.23.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
}
