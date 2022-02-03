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
    var userAnswer = ""
    let image = UIImage(named: "letterButton")
    
    // MARK: - Subviews
    
    @IBOutlet weak var letterFirstButton: UIButton!
    @IBOutlet weak var letterTwoButton: UIButton!
    @IBOutlet weak var letterThreeButton: UIButton!
    @IBOutlet weak var letterFourButton: UIButton!
    @IBOutlet weak var letterFiveButton: UIButton!
    @IBOutlet weak var letterSixButton: UIButton!
    @IBOutlet weak var letterSevenButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var letterEightButton: UIButton!
    @IBOutlet weak var letterNineButton: UIButton!
    @IBOutlet weak var letterTenButton: UIButton!
    @IBOutlet weak var letterElevenButton: UIButton!
    @IBOutlet weak var letterTwelveButton: UIButton!
    @IBOutlet weak var letterThirteenButton: UIButton!
    @IBOutlet weak var letterFourtenButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
    @IBOutlet weak var answerFirstButton: UIButton!
    
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    @IBOutlet weak var answerFiveButton: UIButton!
    
    @IBOutlet weak var answerButtons: UIButton!
    
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
        let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
            
        for index in 0..<letterButtons.count {
            let letter = String(Array(stringLettersRandom)[index])
            letterButtons[index].setTitle(letter, for: .normal)
            
            letterFirstButton.titleLabel!.font =  UIFont(name: "CustomFontName", size: 35)
            
        }
    }
    
    func letterTapped(_ sender: UIButton) {
        
        
        let answerButtons: [UIButton] = [answerFirstButton, answerTwoButton, answerThreeButton, answerFourButton, answerFiveButton]
        
        if userAnswer.count < answerButtons.count {
            answerButtons[userAnswer.count].setTitle(sender.titleLabel?.text, for: .normal)
            answerButtons[userAnswer.count].configuration?.background.image = image
            userAnswer.append((sender.titleLabel?.text)!)
            sender.isHidden = true
        }
        
    }
    
    @IBAction func letterFirstTappedButton(_ sender: UIButton) {
        letterTapped(letterFirstButton)
//        letterFirstButton.isHidden = true
    }

    @IBAction func letterTwoTappedButton(_ sender: UIButton) {
        letterTapped(letterTwoButton)
//        letterTwoButton.isHidden = true
    }
    @IBAction func letterThreeTappedButton(_ sender: UIButton) {
        letterTapped(letterThreeButton)
//        letterThreeButton.isHidden = true
    }
    
    @IBAction func letterFourTappedButton(_ sender: UIButton) {
        letterTapped(letterFourButton)
//        letterFourButton.isHidden = true
    }
    @IBAction func letterFiveTappedButton(_ sender: UIButton) {
        letterTapped(letterFiveButton)
//        letterFiveButton.isHidden = true
    }
    
    @IBAction func letterSixTappedButton(_ sender: UIButton) {
        letterTapped(letterSixButton)
//        letterSixButton.isHidden = true
    }
    
    @IBAction func letterSevenTappedButton(_ sender: UIButton) {
        letterTapped(letterSevenButton)
//        letterSevenButton.isHidden = true
    }
}
    
    
