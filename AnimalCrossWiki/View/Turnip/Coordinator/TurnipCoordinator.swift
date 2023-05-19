//
//  TurnipCoordinator.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/18.
//

import UIKit
import SwiftCoordinator

class TurnipCoordinator: NavigationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UIViewController
    
    private let turnipViewController: TurnipViewController
    
    init() {
        turnipViewController = TurnipViewController()
        let navigationController = UINavigationController(rootViewController: turnipViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        turnipViewController.delegate = self
    }
}

extension TurnipCoordinator: TurnipViewControllerDelegate {
    func didTapResultButton(data: Turnip) {
        print(#function)
        let resultView = TurnipResultViewController()
        resultView.detailInfo.accept(data)
        navigator.push(resultView, animated: true)
    }
    
    
}
