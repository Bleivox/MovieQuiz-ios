//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Никита Долгов on 20.11.23.
//

import UIKit
struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    
    var completion: (() -> Void)
}
