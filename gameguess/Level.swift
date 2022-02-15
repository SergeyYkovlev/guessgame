//
//  LevelModel.swift
//  gameguess
//
//  Created by Сергей Яковлев on 09.02.2022.
//

import Foundation

class Level {
    
    let question: String
    let answer: String
    let hint: String
    
    init(question: String, answer: String, hint: String) {
        self.question = question
        self.answer = answer
        self.hint = hint
    }
}
