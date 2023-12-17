//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 15.12.23.
//

import Foundation
protocol StatisticService {
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
}
