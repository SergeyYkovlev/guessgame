//
//  InfoGameViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 11.02.2022.
//

import Foundation
import UIKit
 
protocol InfoGameViewControllerDelegate {
    func closeInfoGameViewController()
}

class InfoGameViewController: UIViewController {
    
    var delegate: InfoGameViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view .backgroundColor = .systemYellow
        title = "Info Game"
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 70))
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Back menu", for: .normal)
        button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
    }
    
    @objc func backButton() {
        delegate?.closeInfoGameViewController()
        
    }
    
}
