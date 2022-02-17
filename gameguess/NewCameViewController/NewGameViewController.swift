//
//  NewGameViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 11.02.2022.
//

import Foundation
import UIKit

protocol NewGameViewControllerDelegate {
    func closeNewGameViewController()
}

class NewGameViewController: UIViewController {
    
    private struct Constants {
        static let answerButtonSize: CGSize = .init(width: 44, height: 44)
        static let answerButtonSideInset: CGFloat = 10
        static let letterButtonSize: CGSize = .init(width: 44, height: 44)
        static let letterButtonSideInset: CGFloat = 5
    }
    
    var delegate: NewGameViewControllerDelegate?
    
    var userAnswer = ""
    var letterAnswerIndexs = [Int] ()
    let image = UIImage(named: "letterButton")
    let inputImage = UIImage(named: "inputButton")
    let hintImage = UIImage(named: "hintButton")
    let imageLetterButton = UIImage(named: "letterButton")
    let returnButton = UIImage(named: "returnButton")
    var answerButtons: [UIButton] = []
    var letterButton: [UIButton] = []
    var gameService: GameService = GameService.shared
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bg")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var headerImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "header")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var levelNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Level 1"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var answerBackgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bgSolution")
        return view
    }()
    
    private lazy var buttonBackgroundFirstImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private lazy var buttonBackgroundTwoImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    private lazy var backgroundCoinsImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "coinsButton")
        return view
    }()
    
    private lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        return label
    }()
    
    private lazy var hintButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.background.image = hintImage
        button.addTarget(self, action: #selector(hintAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.background.image = returnButton
        button.addTarget(self, action: #selector(undoAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(headerImageView)
        view.addSubview(levelNumberLabel)
        view.addSubview(questionLabel)
        view.addSubview(answerBackgroundImageView)
        view.addSubview(buttonBackgroundFirstImageView)
        view.addSubview(buttonBackgroundTwoImageView)
        view.addSubview(backgroundCoinsImageView)
        view.addSubview(coinsLabel)
        view.addSubview(hintButton)
        view.addSubview(undoButton)
        
        if UserDefaults.standard.value(forKey: "coins") != nil {
            gameService.coins = UserDefaults.standard.value(forKey: "coins") as! NSInteger
        }
        if UserDefaults.standard.value(forKey: "level") != nil {
            gameService.levelNumber = UserDefaults.standard.value(forKey: "level") as! NSInteger
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageView.frame = .init(x: 0,
                                          y: 0,
                                          width: view.frame.width,
                                          height: view.frame.height)
        headerImageView.frame = .init(x: 0,
                                      y: 0,
                                      width: view.frame.width,
                                      height: 88)
        
        levelNumberLabel.frame = .init(x: (view.frame.width - 70) / 2 + 10,
                                       y: (view.frame.origin.y + 42),
                                       width: 70,
                                       height: 40)
        
        questionLabel.frame = .init(x: (view.frame.width - 200) / 2,
                                    y: (view.frame.height - 100) / 2,
                                    width: 200,
                                    height: 100)
        
        answerBackgroundImageView.frame = .init(x: 0,
                                                y: ((view.frame.height - 60) / 2) + 210 ,
                                                width: view.frame.width,
                                                height: 60)
        
        buttonBackgroundFirstImageView.frame = .init(x: 0,
                                                     y: answerBackgroundImageView.frame.origin.y + 80,
                                                     width: view.frame.width,
                                                     height: 60)
        buttonBackgroundTwoImageView.frame = .init(x: 0,
                                                   y: buttonBackgroundFirstImageView.frame.origin.y + 80,
                                                   width: view.frame.width,
                                                   height: 60)
        
        backgroundCoinsImageView.frame = .init(x: (view.frame.width - 70 ) / 2 + 165,
                                               y: (view.frame.origin.y + 42),
                                               width: 70,
                                               height: 40)
        coinsLabel.frame = .init(x: backgroundCoinsImageView.frame.origin.x + 12,
                                 y: (backgroundCoinsImageView.frame.size.height + 44) / 2,
                                 width: 40,
                                 height: 40)
        hintButton.frame = .init(x: (view.frame.size.width + 303) / 2,
                                 y: (answerBackgroundImageView.frame.origin.y + 87),
                                 width: 44,
                                 height: 44)
        undoButton.frame = .init(x: (buttonBackgroundTwoImageView.frame.size.width + 303) / 2,
                                 y: (buttonBackgroundFirstImageView.frame.origin.y + 87),
                                 width: 44,
                                 height: 44)
        fillAnswerButtons()
        fillFirstLetterButton()
        fillLastLetterButton()
        setLevel()
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        answerUndo(sender)
    }
    
    @objc func hintAction(_ sender: UIButton) {
        hint()
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
            //            let y = view.frame.origin.y + 100
            let y = ((view.frame.height - 60) / 2) + 217
            let button = UIButton(frame: CGRect(x: prevButtonPointX ,
                                                y: y,
                                                width: Constants.answerButtonSize.width,
                                                height: Constants.answerButtonSize.height))
            button.configuration = .plain()
            button.configuration?.background.image = inputImage
            button.tintColor = .black
            answerButtons.append(button)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            view.addSubview(button)
            prevButtonPointX += Constants.answerButtonSideInset + Constants.answerButtonSize.width
        }
    }
    
    private func fillFirstLetterButton() {
        let i = (Constants.letterButtonSize.width * 7 + Constants.letterButtonSideInset * 6)
        var prevButtonPointX: CGFloat = (buttonBackgroundFirstImageView.frame.size.width - i - Constants.letterButtonSize.width) / 2
        
        for _ in 0..<7 {
            //            let y = (view.frame.size.height - Constants.letterButtonSize.height) / 2 + 130
            let button = UIButton(frame: CGRect(x: prevButtonPointX,
                                                y: answerBackgroundImageView.frame.origin.y + 87,
                                                width: Constants.letterButtonSize.width,
                                                height: Constants.letterButtonSize.height))
            button.configuration = .plain()
            button.configuration?.background.image = imageLetterButton
            button.tintColor = .black
            button.addTarget(self, action: #selector(lettersButtonAction), for: .touchUpInside)
            view.addSubview(button)
            letterButton.append(button)
            prevButtonPointX += Constants.letterButtonSideInset + Constants.letterButtonSize.width
        }
    }
    
    private func fillLastLetterButton() {
        let i = (Constants.letterButtonSize.width * 7 + Constants.letterButtonSideInset * 6)
        var prevButtonPointX: CGFloat = (buttonBackgroundFirstImageView.frame.size.width - i - Constants.letterButtonSize.width) / 2
        
        for _ in 0..<7 {
            //            let y = ((view.frame.size.height - Constants.letterButtonSize.height) / 2) - 30
            let button = UIButton(frame: CGRect(x: prevButtonPointX,
                                                y: buttonBackgroundFirstImageView.frame.origin.y + 87,
                                                width: Constants.letterButtonSize.width,
                                                height: Constants.letterButtonSize.height))
            button.configuration = .plain()
            button.configuration?.background.image = imageLetterButton
            button.tintColor = .black
            letterButton.append(button)
            button.addTarget(self, action: #selector(lettersButtonAction), for: .touchUpInside)
            view.addSubview(button)
            prevButtonPointX += Constants.letterButtonSideInset + Constants.letterButtonSize.width
        }
    }
    
    func fillButton(letters: String) {
        for index in 0..<letterButton.count {
            let letter = String(Array(letters)[index])
            letterButton[index].setTitle(letter, for: .normal)
        }
    }
    
    private func letterTapped(_ sender: UIButton) {
        if userAnswer.count < answerButtons.count {
            answerButtons[userAnswer.count].setTitle(sender.titleLabel?.text, for: .normal)
            answerButtons[userAnswer.count].configuration?.background.image = image
            answerButtons[userAnswer.count].isEnabled = true
            userAnswer.append((sender.titleLabel?.text)!)
            sender.isHidden = true
            letterAnswerIndexs.append(letterButton.firstIndex(of: sender)!)

            checkAnswerRigth()
        }
    }
    
    @objc func lettersButtonAction(_ sender: UIButton) {
        letterTapped(sender)
    }
    
    func backmenu(action: UIAlertAction!) {
        UserDefaults.standard.setValue(1, forKey: "level")
        gameService.increaseCoins()
        delegate?.closeNewGameViewController()
    }
    
    private func hint() {
        let alert = UIAlertController(title: "HINT", message: gameService.getHint(), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func actionResetLevel(action: UIAlertAction!) {
        gameService.increaseCoins()
        if !gameService.isLastLevel() {
            gameService.increaseLevel()
        }
        for button in answerButtons {
            button.removeFromSuperview()
        }
        for button in letterButton {
            button.removeFromSuperview()
        }
        userAnswer.removeAll()
        answerButtons.removeAll(keepingCapacity: true)
        letterButton.removeAll()
        
        setLevel()
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
    
    @objc func undoAction(_ sender: UIButton) {
        guard !userAnswer.isEmpty else {
            return
        }
        let index = letterAnswerIndexs.last
        letterButton[index!].isHidden = false
        letterAnswerIndexs.removeLast()
        answerButtons[userAnswer.count - 1].configuration?.background.image = inputImage
        answerButtons[userAnswer.count - 1].setTitle("", for: .normal)
        userAnswer.removeLast()
    }
    
    func answerUndo(_ sender: UIButton) {
        let index = letterAnswerIndexs.last!
        for button in answerButtons.reversed() {
            if button.titleLabel?.text?.isEmpty == false {
                if button == sender {
                    letterButton[index].isHidden = false
                    letterAnswerIndexs.removeLast()
                    userAnswer.removeLast()
                    sender.configuration?.background.image = inputImage
                    sender.titleLabel?.text = ""
                    sender.setTitle("", for: .normal)
                    sender.isEnabled = false
                } else {
                    return
                }
            }
        }
    }
}
