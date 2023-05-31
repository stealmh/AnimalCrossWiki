//
//  CreatureCoordinator.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/31.
//

import UIKit
import SwiftCoordinator

class CreatureCoordinator: NavigationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UIViewController
    
    private let creatureViewController: CreatureViewController
    
    init() {
        creatureViewController = CreatureViewController()
        let navigationController = UINavigationController(rootViewController: creatureViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        
    }
}
