//
//  TabBarViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let citizenCoordinator = CitizenCoordinator()
    private let bugCoordinator = BugCoordinator()
    
    private var citizenViewController: UIViewController {
        return citizenCoordinator.rootViewController
    }
    private var bugViewController: UIViewController {
        return bugCoordinator.rootViewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citizenViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        bugViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        citizenCoordinator.start()
        bugCoordinator.start()
        self.viewControllers = [citizenViewController, bugViewController]
    }
    
    
    func setUpTabBar() {
    }


}
