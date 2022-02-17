//
//  ViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 31.01.2022.
//

import UIKit

protocol ViewControllerDelegate {
    func showGameViewController()
    func showInfoGameViewController()
    func showStoreViewController()
}

class ViewController: UIViewController {

    var delegate: ViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Subviews
    
    @IBOutlet weak var soundButton: UIButton!
    
    // MARK: - Action

    @IBAction func playButton(_ sender: UIButton) {
        delegate?.showGameViewController()
    }

    @IBAction func howToPlayButton(_ sender: UIButton) {
        delegate?.showInfoGameViewController()
    }

    @IBAction func storeButton(_ sender: UIButton) {
        delegate?.showStoreViewController()
    }
}
