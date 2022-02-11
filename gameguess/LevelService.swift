//
//  LevelService.swift
//  gameguess
//
//  Created by Сергей Яковлев on 09.02.2022.
//

import Foundation

class LevelService {
    
    static var shared: LevelService = {
        let cell = LevelService()
        return cell
    }()
    
    let level: [Level]  =     [Level(text: "1+2", answer: "THREE", hint: "T"),
                              Level(text: "2+2", answer: "FOUR", hint: "F"),
                              Level(text: "2+3", answer: "FIVE", hint: "F")]
    
}
