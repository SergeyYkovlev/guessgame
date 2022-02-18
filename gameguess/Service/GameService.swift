//
//  LevelService.swift
//  gameguess
//
//  Created by Сергей Яковлев on 09.02.2022.
//

import Foundation

class GameService {
    
    static var shared: GameService = {
        let cell = GameService()
        return cell
    }()
    
    var levelNumber: Int = 1
    var coins: Int = 0
    
    let levels: [Level] = [Level(question: "1+2", answer: "THREE", hint: "T"),
                          Level(question: "2+2", answer: "FOUR", hint: "F"),
                          Level(question: "2+3", answer: "FIVE", hint: "F")]
    
    func isLastLevel() -> Bool {
        return levelNumber >= levels.count
    }
    
    func increaseLevel() {
        levelNumber += 1
        UserDefaults.standard.setValue(levelNumber, forKey: "level")
    }
    
    func increaseCoins() {
        coins += 10
        UserDefaults.standard.setValue(coins, forKey: "coins")
    }
 
    func getRandomLetters() -> String {
        let letters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let answer = levels[levelNumber - 1].answer
        let lenth = 14 - answer.count
        var stringLetters = ""
        var stringLettersRandom = ""
        
        for _ in 0..<lenth {
            let randomInt = Int.random(in: 0..<letters.count)
            let randomLetter = Array(letters)[randomInt]
            stringLetters.append(randomLetter)
        }
        
        stringLetters += answer
        
        for _ in 0..<stringLetters.count {
            let randomInt = Int.random(in: 0..<stringLetters.count)
            let randomLetter = Array(stringLetters)[randomInt]
            stringLettersRandom.append(randomLetter)
            stringLetters.remove(at: stringLetters.firstIndex(of: randomLetter)!)
        }
        return stringLettersRandom
    }
    
    func getQuestion() -> String {
        return levels[levelNumber - 1].question
    }
    
    func getAnswer() -> String {
        return levels[levelNumber - 1].answer
    }
    
    func getHint() -> String {
        return levels[levelNumber - 1].hint
    }
}
