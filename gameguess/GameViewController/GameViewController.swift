//
//  GameViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 31.01.2022.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    private struct Constants {
        static let answerButtonSize: CGSize = .init(width: 44, height: 44)
        static let answerButtonSideInset: CGFloat = 10
    }
    
    var userAnswer = ""
    var letterAnswerIndexs = [Int] ()
    let image = UIImage(named: "letterButton")
    let inputImage = UIImage(named: "inputButton")
    var answerButtons: [UIButton] = []
    var gameService: GameService = GameService.shared
    
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
    @IBOutlet weak var levelNumberLabel: UILabel!
    
    lazy var letterButtons: [UIButton] = [letterFirstButton, letterTwoButton, letterThreeButton, letterFourButton, letterFiveButton, letterSixButton, letterSevenButton, letterEightButton, letterNineButton, letterTenButton, letterElevenButton, letterTwelveButton, letterThirteenButton, letterFourtenButton ]
    
    // MARK: - Livecycle
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "coins") != nil {
            gameService.coins = UserDefaults.standard.value(forKey: "coins") as! NSInteger
        }
        if UserDefaults.standard.value(forKey: "level") != nil {
            gameService.levelNumber = UserDefaults.standard.value(forKey: "level") as! NSInteger
        }
        
        setLevel()
    }
    
    // MARK: - Action
    
    @objc func buttonAction(_ sender: UIButton) {
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
    func backmenu(action: UIAlertAction!) {
        navigationController?.popViewController(animated: true)
        UserDefaults.standard.setValue(1, forKey: "level")
    }
    
    private func setLevel() {
        questionLabel.text = gameService.getQuestion()
        coinsLabel.text = String(gameService.coins)
        levelNumberLabel.text = "Level \(gameService.levelNumber)"
        
        let letters = gameService.getRandomLetters()
        fillButton(letters: letters)
        
        
    }
    
    private func fillAnswerButtons() {
        let answer = gameService.getAnswer()
        let i = Constants.answerButtonSize.width * CGFloat(answer.count) + Constants.answerButtonSideInset * CGFloat(answer.count - 1)
        var prevButtonPointX: CGFloat = (view.frame.width - i) / 2
        for _ in 0..<answer.count{
            let y = (answerBackground.frame.size.height - Constants.answerButtonSize.height) / 2 + answerBackground.frame.origin.y
            let button = UIButton(frame: CGRect(x: prevButtonPointX ,
                                                y: y,
                                                width: Constants.answerButtonSize.width,
                                                height: Constants.answerButtonSize.height))
            button.configuration = .plain()
            button.configuration?.background.image = inputImage
            button.tintColor = .black
            answerButtons.append(button)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.view.addSubview(button)
            prevButtonPointX += Constants.answerButtonSideInset + Constants.answerButtonSize.width
        }
    }
    
    
    
    func actionResetLevel(action: UIAlertAction!) {
        gameService.increaseCoins()
        if !gameService.isLastLevel() {
            gameService.increaseLevel()
        }
        for button in answerButtons {
            button.removeFromSuperview()
        }
        for button in letterButtons {
            button.isHidden = false
        }
        userAnswer.removeAll()
        answerButtons.removeAll(keepingCapacity: true)
        
        setLevel()
    }

    func fillButton(letters: String) {
        for index in 0..<letterButtons.count {
            let letter = String(Array(letters)[index])
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

            letterAnswerIndexs.append(letterButtons.firstIndex(of: sender)!)
            
            checkAnswerRigth()
        }
    }
    
    private func checkAnswerRigth() {
        let answer = gameService.getAnswer()
        if userAnswer == answer {
            if gameService.isLastLevel() {
                let alert = UIAlertController(title: "Level Complited", message: "THE END", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Back to menu!", style: .default, handler: backmenu))
                present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Level Complited", message: gameService.getAnswer(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Next Level", style: .default, handler: actionResetLevel(action:)))
                present(alert, animated: true)
            }
        }
    }
    
    func undo(_ sender: UIButton) {
        guard !userAnswer.isEmpty else {
            return
        }
        let index = letterAnswerIndexs.last
        letterButtons[index!].isHidden = false
        letterAnswerIndexs.removeLast()
        answerButtons[userAnswer.count - 1].configuration?.background.image = inputImage
        answerButtons[userAnswer.count - 1].setTitle("", for: .normal)
        userAnswer.removeLast()
    }
    
    func hint() {
        let alert = UIAlertController(title: "HINT", message: gameService.getHint(), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func answerUndo(_ sender: UIButton) {
        let index = letterAnswerIndexs.last!
        
        for button in answerButtons.reversed() where button.titleLabel?.text?.isEmpty == false && button == sender {
            letterButtons[index].isHidden = false
            letterAnswerIndexs.removeLast()
            userAnswer.removeLast()
            sender.configuration?.background.image = inputImage
            sender.titleLabel?.text = ""
            sender.setTitle("", for: .normal)
            sender.isEnabled = false
        }
    }
}
