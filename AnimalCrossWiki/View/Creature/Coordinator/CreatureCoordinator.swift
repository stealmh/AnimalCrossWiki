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
        creatureViewController = CreatureViewController(viewModel: CreatureViewModel())
        let navigationController = UINavigationController(rootViewController: creatureViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        creatureViewController.delegate = self
    }
}

extension CreatureCoordinator: CreatureViewControllerDelegate {
    func didTapCreatureCell(_ viewController: CreatureViewController) {
        ///Todo: 해산물 뷰 만들기
    }
    
    //단일 뷰
    func didTapFishCell(_ viewController: CreatureViewController) {
        let fishVC = FishViewController()
        navigator.push(fishVC, animated: true)
    }
    
    //다중 뷰
    func didTapBugCell(_ viewController: CreatureViewController) {
        let coordinator = BugCoordinator(navigator: navigator)
        pushCoordinator(coordinator, animated: true)
    }
}
