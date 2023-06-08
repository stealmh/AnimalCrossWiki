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
    var rootViewController = BugViewController(viewModel: BugViewModel())
    
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
        detail.delegate = self
        viewController.present(detail, animated: true)
    }
}

extension BugCoordinator: BugDelegate {
        func returnValue(vc: MyInfoViewController, south: Bool?, idx: Int?) {
            vc.dismiss(animated: true, completion: { [weak self] in
                if let south = south, let idx = idx {
                    if south {
                        let a = self?.rootViewController.viewModel.users_copy.filter { $0.south.months_array.contains(idx + 1) }
                        self?.rootViewController.viewModel.users.accept(a!)
                    }
                    else {
                        let a = self?.rootViewController.viewModel.users_copy.filter { $0.north.months_array.contains(idx + 1) }
                        self?.rootViewController.viewModel.users.accept(a!)
                    }
                }
            })
        }
}
