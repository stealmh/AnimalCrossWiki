//
//  BugCoordinator.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/27.
//

import UIKit
import SwiftCoordinator

class BugCoordinator: NavigationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let bugViewController: BugViewController
    
    init() {
        bugViewController = BugViewController()
        let navigationController = UINavigationController(rootViewController: bugViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        bugViewController.delegate = self
    }
}

extension BugCoordinator: BugViewControllerDelegate {

    func didTapSetting(_ viewController: BugViewController) {
        let detail = MyInfoViewController()
        detail.modalTransitionStyle = .crossDissolve
        detail.modalPresentationStyle = .overFullScreen
        detail.delegate = viewController
        viewController.present(detail, animated: true)
    }
    
}
