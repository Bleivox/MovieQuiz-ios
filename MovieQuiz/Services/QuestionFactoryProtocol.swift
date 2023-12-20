//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 19.11.23.
//

import Foundation

protocol QuestionFactoryProtocol {
    var delegate: QuestionFactoryDelegate? { get set }
    func requestNextQuestion()
    func loadData() 
}
