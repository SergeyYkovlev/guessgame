//
//  StoreViewController.swift
//  gameguess
//
//  Created by Сергей Яковлев on 11.02.2022.
//

import Foundation
import UIKit

protocol StoreViewControllerDelegate {
    func closeStoreViewController()
}
class StoreViewController: UIViewController{
    
    var delegate: StoreViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        title = "Store"
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 70))
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Back menu", for: .normal)
        button.addTarget(self, action: #selector(backStoreButton), for: .touchUpInside)
    }
    
    @objc func backStoreButton() {
        delegate?.closeStoreViewController()
    }
}

