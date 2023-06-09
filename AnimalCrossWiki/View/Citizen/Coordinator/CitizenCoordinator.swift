//
//  CitizenCoordinator.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/27.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftCoordinator

class CitizenCoordinator: NavigationCoordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigator: NavigatorType
    var rootViewController: UINavigationController
    
    private let citizenViewController: CitizenViewController
    
    init() {
        citizenViewController = CitizenViewController(viewModel: CitizenViewModel())
        let navigationController = UINavigationController(rootViewController: citizenViewController)
        self.navigator = Navigator(navigationController: navigationController)
        self.rootViewController = navigationController
    }
    
    func start() {
        citizenViewController.delegate = self
    }
}

extension CitizenCoordinator: CitizenViewControllerDelegate {
    
    func didTapCell(_ viewController: CitizenViewController,data: ControlEvent<AnimalModel>.Element) {
        print(#function)
        let animalDetailView = AnimalDetailViewController()
        animalDetailView.modalTransitionStyle = .crossDissolve
        animalDetailView.modalPresentationStyle = .overFullScreen
        animalDetailView.detailInfo.accept(data)
        viewController.present(animalDetailView, animated: true)
    }
}
