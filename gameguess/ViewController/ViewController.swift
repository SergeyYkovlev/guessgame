//
//  ViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Subviews
    
    @IBOutlet weak var soundButton: UIButton!
    
    // MARK: - Action

    @IBAction func playButton(_ sender: UIButton) {
        let gameViewController = GameViewController()
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    @IBAction func howToPlayButton(_ sender: UIButton) {
        let infoGameViewController = InfoGameViewController()
        navigationController?.pushViewController(infoGameViewController, animated: true)
    }
    @IBAction func storeButton(_ sender: UIButton) {
        let storeViewController = StoreViewController()
        navigationController?.pushViewController(storeViewController, animated: true)
    }
}
