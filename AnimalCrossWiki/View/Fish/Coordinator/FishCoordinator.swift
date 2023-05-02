//
//  FishCoordinator.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/02.
//

import UIKit
import SwiftCoordinator

class FishCoordinator: NavigationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UIViewController
    
    private let fishViewController: FishViewController
    
    init() {
        fishViewController = FishViewController()
        let navigationController = UINavigationController(rootViewController: fishViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    
    
    func start() {
//        fishViewController.delegate = self
    }
    
    
}
