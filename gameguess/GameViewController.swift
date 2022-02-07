//
//  GameViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 31.01.2022.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    let answer = "ANSWE"
    var stringLettersRandom = ""
    var userAnswer = ""
    var letterAnswerIndexs = [Int] ()
    let image = UIImage(named: "letterButton")
    let inputImage = UIImage(named: "inputButton")
    
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
    
   
    // MARK: - Livecycle
    override func viewDidLoad() {
        super .viewDidLoad()
        random()
        fillButton()
    }
    
    // MARK: - Action
    
    @IBAction func undoFirstButton(_ sender: UIButton) {
        answerUndo(answerFirstButton)
    }
    
    @IBAction func undoTwoButton(_ sender: UIButton) {
        answerUndo(answerTwoButton)
    }
    
    @IBAction func undoThreeButton(_ sender: UIButton) {
        answerUndo(answerThreeButton)
    }

    @IBAction func undoFourButton(_ sender: UIButton) {
        answerUndo(answerFourButton)
    }
    
    @IBAction func undoFiveButton(_ sender: UIButton) {
        answerUndo(answerFiveButton)
    }
    
    @IBAction func undoActionButton(_ sender: UIButton) {
        undo(sender)
    }
    
    @IBAction func lettersTapped(_ sender: UIButton) {
        letterTapped(sender)
    }
    @IBAction func showHintButton(_ sender: Any) {
        hint()
    }
    
    // MARK: - Private
    
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
            answerButtons[userAnswer.count].isEnabled = true
            userAnswer.append((sender.titleLabel?.text)!)
            sender.isHidden = true
            let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
            
            letterAnswerIndexs.append(letterButtons.firstIndex(of: sender)!)
            
            if userAnswer == answer{
                let clue = UIAlertController(title: "Level Complited", message: "ANSWE", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             
                clue.addAction(action)
                
                present(clue, animated: true, completion: nil)
                
            }
        }
    }
    
    func undo(_ sender: UIButton) {
        if !userAnswer.isEmpty {
            let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
            let answerButtons: [UIButton] = [answerFirstButton, answerTwoButton, answerThreeButton, answerFourButton, answerFiveButton]
        let index = letterAnswerIndexs.last
        letterButtons[index!].isHidden = false
        letterAnswerIndexs.removeLast()
        userAnswer.removeLast()
        answerButtons[userAnswer.count].configuration?.background.image = inputImage
        answerButtons[userAnswer.count].setTitle("", for: .normal)
        }
    }
    
    func hint() {
        let clue = UIAlertController(title: "HINT", message: "A", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     
        clue.addAction(action)
        
        present(clue, animated: true, completion: nil)
    }
    
    func answerUndo(_ sender: UIButton) {
        
        let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
        let answerButtons: [UIButton] = [answerFirstButton, answerTwoButton, answerThreeButton, answerFourButton, answerFiveButton]
        let index = letterAnswerIndexs.last!
        
        for button in answerButtons.reversed() {
            if button.titleLabel?.text?.isEmpty == false {
                if button == sender {
                    letterButtons[index].isHidden = false
                    letterAnswerIndexs.removeLast()
                    userAnswer.removeLast()
                    sender.configuration?.background.image = inputImage
                    sender.titleLabel?.text = ""
                    sender.setTitle("", for: .normal)
                    sender.isEnabled = false
                }
                return
            }
        }
    }
}


