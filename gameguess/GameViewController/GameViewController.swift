//
//  GameViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 31.01.2022.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    var answer = ""
    var stringLettersRandom = ""
    var userAnswer = ""
    var letterAnswerIndexs = [Int] ()
    let image = UIImage(named: "letterButton")
    let inputImage = UIImage(named: "inputButton")
    var answerButtons: [UIButton] = []
    var levelService: LevelService = LevelService.shared
    var level = 1
    var coins = 0
    
    
    
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
    @IBOutlet weak var answerBackground: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var levelnemberLabel: UILabel!
    
    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "coins") != nil {
            coins = UserDefaults.standard.value(forKey: "coins") as! NSInteger
        }
        if UserDefaults.standard.value(forKey: "level") != nil {
            level = UserDefaults.standard.value(forKey: "level") as! NSInteger
        }
        
        questionLabel.text = levelService.level[level - 1].text
        questionLabel.font = questionLabel.font.withSize(50)
        questionLabel.textColor = .white
        answer = levelService.level[level - 1].answer
        hintButton.titleLabel?.text = levelService.level[level - 1].hint

        resetLevel()
        
//        var prevButtonPointX = 0
//        for _ in 0..<answer.count{
//            if answerButtons.isEmpty {
//                let i = (44 * answer.count + 10 * (answer.count - 1))
//                prevButtonPointX = Int((Int(view.frame.width) - i) / 2)
//                let y = (answerBackground.frame.size.height - 44) / 2 + answerBackground.frame.origin.y
//                let button = UIButton(frame: CGRect(x: prevButtonPointX , y: Int(y), width: 44, height: 44))
//                button.configuration = .plain()
//                button.configuration?.background.image = inputImage
//                button.tintColor = .black
//                answerButtons.append(button)
//                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//                self.view.addSubview(button)
//
//            }  else if !answerButtons.isEmpty {
//                let a = (prevButtonPointX + 54)
//                let b = (answerBackground.frame.size.height - 44) / 2 + answerBackground.frame.origin.y
//                let button = UIButton(frame: CGRect(x: a, y: Int(b), width: 44, height: 44))
//                button.configuration = .plain()
//                button.configuration?.background.image = inputImage
//                button.tintColor = .black
//                button.setTitle("", for: .normal)
//                answerButtons.append(button)
//                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//                prevButtonPointX = a
//                self.view.addSubview(button)
//            }
//        }
//        random()
//        fillButton()
    }
    
    // MARK: - Action
    
    @IBAction func buttonAction(_ sender: UIButton) {
        answerUndo(sender)
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
    func backmenu(action: UIAlertAction!){
        _ = navigationController?.popToRootViewController(animated: true)
        
        UserDefaults.standard.setValue(1, forKey: "level")
        
    }
    
    func resetLevel() {
        coinsLabel.text = String(coins)
        levelnemberLabel.text = "Level \(level)"

        random()
        fillButton()
        
        var prevButtonPointX = 0
        for _ in 0..<answer.count{
            if answerButtons.isEmpty {
                let i = (44 * answer.count + 10 * (answer.count - 1))
                prevButtonPointX = Int((Int(view.frame.width) - i) / 2)
                let y = (answerBackground.frame.size.height - 44) / 2 + answerBackground.frame.origin.y
                let button = UIButton(frame: CGRect(x: prevButtonPointX , y: Int(y), width: 44, height: 44))
                button.configuration = .plain()
                button.configuration?.background.image = inputImage
                button.tintColor = .black
                answerButtons.append(button)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                self.view.addSubview(button)
                
            }  else if !answerButtons.isEmpty {
                let a = (prevButtonPointX + 54)
                let b = (answerBackground.frame.size.height - 44) / 2 + answerBackground.frame.origin.y
                let button = UIButton(frame: CGRect(x: a, y: Int(b), width: 44, height: 44))
                button.configuration = .plain()
                button.configuration?.background.image = inputImage
                button.tintColor = .black
                button.setTitle("", for: .normal)
                answerButtons.append(button)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                prevButtonPointX = a
                self.view.addSubview(button)
            }
        }
    }
    
    func actionResetLevel(action: UIAlertAction!) {
        coins += 10
        UserDefaults.standard.setValue(coins, forKey: "coins")
        if level <= levelService.level.count {
            level += 1
            UserDefaults.standard.setValue(level, forKey: "level")
        }
        for batn in answerButtons {
            batn.removeFromSuperview()
        }
        let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
        for batn in letterButtons {
            batn.isHidden = false
        }
        answer.removeAll()
        userAnswer.removeAll()
        answerButtons.removeAll(keepingCapacity: true)
        questionLabel.text = levelService.level[level - 1].text
        questionLabel.font = questionLabel.font.withSize(50)
        questionLabel.textColor = .white
        answer = levelService.level[level - 1].answer
        hintButton.titleLabel?.text = levelService.level[level - 1].hint
        
        resetLevel()
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
        
        for _ in 0..<stringLetters.count {
            let randomInt = Int.random(in: 0..<stringLetters.count)
            let randomLetter = Array(stringLetters)[randomInt]
            stringLettersRandom.append(randomLetter)
            stringLetters.remove(at: stringLetters.firstIndex(of: randomLetter)!)
        }
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
        if userAnswer.count < answerButtons.count {
            answerButtons[userAnswer.count].setTitle(sender.titleLabel?.text, for: .normal)
            answerButtons[userAnswer.count].configuration?.background.image = image
            answerButtons[userAnswer.count].isEnabled = true
            userAnswer.append((sender.titleLabel?.text)!)
            sender.isHidden = true
            
            let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
            letterAnswerIndexs.append(letterButtons.firstIndex(of: sender)!)
            if userAnswer == answer{
                if level < levelService.level.count{
                    let clue = UIAlertController(title: "Level Complited", message: levelService.level[level - 1].answer, preferredStyle: .alert)
                    clue.addAction(UIAlertAction(title: "Next Level", style: .default, handler: actionResetLevel(action:)))
                    present(clue, animated: true)
                } else {
                    let clue = UIAlertController(title: "Level Complited", message: "THE END", preferredStyle: .alert)
                    clue.addAction(UIAlertAction(title: "Back to menu!", style: .default, handler: backmenu))
                    present(clue, animated: true)
                }
            }
        }
    }
    
    func undo(_ sender: UIButton) {
        if !userAnswer.isEmpty {
            let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
            let index = letterAnswerIndexs.last
            letterButtons[index!].isHidden = false
            letterAnswerIndexs.removeLast()
            userAnswer.removeLast()
            answerButtons[userAnswer.count].configuration?.background.image = inputImage
            answerButtons[userAnswer.count].setTitle("", for: .normal)
        }
    }
    
    func hint() {
        let clue = UIAlertController(title: "HINT", message: levelService.level[level - 1].hint, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        clue.addAction(action)
        present(clue, animated: true, completion: nil)
    }
    
    func answerUndo(_ sender: UIButton) {
        let letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
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


