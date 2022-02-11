//
//  LevelModel.swift
//  gameguess
//
//  Created by Сергей Яковлев on 09.02.2022.
//

import Foundation

class Level {
    
    let text: String
    let answer: String
    let hint: String
    
    init(text: String, answer: String, hint: String) {
        self.text = text
        self.answer = answer
        self.hint = hint
    }
}
