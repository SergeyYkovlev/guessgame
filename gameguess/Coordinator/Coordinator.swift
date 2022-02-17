//
//  Coordinator.swift
//  gameguess
//
//  Created by Сергей Яковлев on 17.02.2022.
//


import UIKit

public protocol Coordinator: AnyObject {
    var delegate: CoordinatorDelegate? { get set }
    func append(child: Coordinator)
    func remove(child: Coordinator)
}

public protocol CoordinatorDelegate: AnyObject {
    func childCoordinatorDidFinish(_ childCoordinator: Coordinator)
}

extension CoordinatorDelegate where Self: Coordinator {
    public func childCoordinatorDidFinish(_ coordinator: Coordinator) {
        remove(child: coordinator)
        coordinator.delegate = nil
    }
}

// MARK: - BaseCoordinator

open class BaseCoordinator<V: UIViewController>: Coordinator, CoordinatorDelegate {

    public let rootViewController: V
    private var childCoordinators: [Coordinator] = []
    public weak var delegate: CoordinatorDelegate?

    public init(rootViewController: V) {
        self.rootViewController = rootViewController
    }

    func start() {

    }

    public func append(child: Coordinator) {
        child.delegate = self
        childCoordinators.append(child)
    }

    public func remove(child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return coordinator === child
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
