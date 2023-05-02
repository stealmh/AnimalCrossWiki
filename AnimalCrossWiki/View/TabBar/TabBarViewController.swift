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
    private let fishCoordinator = FishCoordinator()
    
    private var citizenViewController: UIViewController {
        return citizenCoordinator.rootViewController
    }
    private var bugViewController: UIViewController {
        return bugCoordinator.rootViewController
    }
    private var fishViewController: UIViewController {
        return fishCoordinator.rootViewController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citizenViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        bugViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        fishViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        
        citizenCoordinator.start()
        bugCoordinator.start()
        fishCoordinator.start()
        
        self.viewControllers = [citizenViewController, bugViewController, fishViewController]
    }
    
    
    func setUpTabBar() {
    }


}
