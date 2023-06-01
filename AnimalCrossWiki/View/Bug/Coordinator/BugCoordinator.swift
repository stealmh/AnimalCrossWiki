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
    var rootViewController = BugViewController()
    
    init(navigator: NavigatorType) {
        self.navigator = navigator
    }
    
    func start() {
        rootViewController.delegate = self
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
