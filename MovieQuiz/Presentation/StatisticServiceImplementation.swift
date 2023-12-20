//
//  StatisticServiceImplementation.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 15.12.23.
//

import Foundation

 final class StatisticServiceImplementation: StatisticService {
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        let NewRound = GameRecord(correct: count, total: amount, date: Date())
        if NewRound.CompareRecord(bestGame) {
            bestGame = NewRound
        }
        correct += Double(NewRound.correct)
        total += Double(NewRound.total)
    }
    
    var correct: Double {
        get {
            userDefaults.double(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue )
        }
    }
    
    var total: Double {
        get {
            userDefaults.double(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue )
        }
    }
    var totalAccuracy: Double {
        get {
            (correct / total) * 100
        }
    }
    
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
            
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
            
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return record
        }

        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
                userDefaults.set(data, forKey: Keys.bestGame.rawValue)
            
        }
    }
    
    
    
}
