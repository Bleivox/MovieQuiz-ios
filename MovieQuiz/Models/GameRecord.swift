//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 15.12.23.
//

import Foundation
struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func CompareRecord(_ another: GameRecord) -> Bool {
        correct > another.correct
    }
}
