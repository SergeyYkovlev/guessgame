//
//  MainCoordinator.swift
//  gameguess
//
//  Created by Сергей Яковлев on 17.02.2022.
//

import Foundation
import  UIKit

class MainCoordinator: BaseCoordinator <UINavigationController> {
  
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        let rootViewController = UINavigationController()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        super.init(rootViewController: rootViewController)
    }
    
    override func start() {
        let viewController = ViewController()
        viewController.delegate = self
        rootViewController.pushViewController(viewController, animated: true)
    }
}

// MARK: - ViewControllerDelegate

extension MainCoordinator: ViewControllerDelegate {
    
    func showGameViewController() {
        let gameViewController = NewGameViewController()
        gameViewController.delegate = self
        rootViewController.pushViewController(gameViewController, animated: true)
    }
    
    func showInfoGameViewController() {
        let infoGameViewController = InfoGameViewController()
        infoGameViewController.delegate = self
        rootViewController.pushViewController(infoGameViewController, animated: true)
    }
    
    func showStoreViewController() {
        let storeViewController = StoreViewController()
        storeViewController.delegate = self
        rootViewController.pushViewController(storeViewController, animated: true)
    }
}

// MARK: - NewGameViewControllerDelegate

extension MainCoordinator: NewGameViewControllerDelegate {
    func closeNewGameViewController() {
        rootViewController.popViewController(animated: true)
    }
}

extension MainCoordinator: InfoGameViewControllerDelegate {
    func closeInfoGameViewController() {
        rootViewController.popViewController(animated: true)
    }
}

extension MainCoordinator: StoreViewControllerDelegate {
    func closeStoreViewController() {
        rootViewController.popViewController(animated: true)
    }
}
