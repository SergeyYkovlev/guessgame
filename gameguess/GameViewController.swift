//
//  GameViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 31.01.2022.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    let answer = "ANSWER"
    var stringLettersRandom = ""
    
    // MARK: - Subviews
    
    @IBOutlet weak var leterFirstButton: UIButton!
    @IBOutlet weak var leterTwoButton: UIButton!
    @IBOutlet weak var leterThreeButton: UIButton!
    @IBOutlet weak var leterFourButton: UIButton!
    @IBOutlet weak var leterFiveButton: UIButton!
    @IBOutlet weak var leterSixButton: UIButton!
    @IBOutlet weak var leterSevenButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var leterEightButton: UIButton!
    @IBOutlet weak var leterNineButton: UIButton!
    @IBOutlet weak var leterTenButton: UIButton!
    @IBOutlet weak var leterElevenButton: UIButton!
    @IBOutlet weak var leterTwelveButton: UIButton!
    @IBOutlet weak var leterThirteenButton: UIButton!
    @IBOutlet weak var leterFourtenButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        random()
        fillButton()
    }
    
    func random() {
        let letters : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lenth = 14 - answer.count
        var stringLetters = ""
        stringLettersRandom = ""
        
        for _ in 0..<lenth {
            let randomInt = Int.random(in: 0..<letters.count)
            let randomLetter = Array(letters)[randomInt]
            stringLetters.append(randomLetter)
        }
        
        stringLetters += answer
        print(stringLetters)
        
        for _ in 0..<stringLetters.count {
            let randomInt = Int.random(in: 0..<stringLetters.count)
            let randomLetter = Array(stringLetters)[randomInt]
            stringLettersRandom.append(randomLetter)
            stringLetters.remove(at: stringLetters.firstIndex(of: randomLetter)!)
        }
        
        print(stringLettersRandom)
    }
    
    func fillButton() {
        let letterButtons: [UIButton] = [leterFirstButton, leterTwoButton, leterThreeButton, leterFourButton, leterFiveButton, leterSixButton, leterSevenButton, leterEightButton, leterNineButton, leterTenButton, leterElevenButton, leterTwelveButton, leterThirteenButton, leterFourtenButton ]
            
        for index in 0..<letterButtons.count {
            let letter = String(Array(stringLettersRandom)[index])
            letterButtons[index].setTitle(letter, for: .normal)
            
        }
    }
}
