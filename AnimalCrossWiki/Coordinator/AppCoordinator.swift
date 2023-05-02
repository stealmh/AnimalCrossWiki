//
//  AppCoordinator.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/04/27.
//

import UIKit
import SwiftCoordinator

class AppCoordinator: PresentationCoordinator {
    var childCoordinators: [Coordinator] = []
    var rootViewController = TabBarViewController()
    
    init(window: UIWindow) {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func start() {}
}
