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
    private let turnipCoordinator = TurnipCoordinator()
    
    private var citizenViewController: UIViewController {
        return citizenCoordinator.rootViewController
    }
    private var bugViewController: UIViewController {
        return bugCoordinator.rootViewController
    }
    private var fishViewController: UIViewController {
        return fishCoordinator.rootViewController
    }
    private var turnipViewController: UIViewController {
        return turnipCoordinator.rootViewController
    }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, MyTabBar.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citizenViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        bugViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        fishViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        turnipViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 3)
        
        citizenCoordinator.start()
        bugCoordinator.start()
        fishCoordinator.start()
        turnipCoordinator.start()
        
        self.viewControllers = [citizenViewController, bugViewController, fishViewController, turnipViewController]
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
    
        tabBar.barTintColor = .cyan
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    class MyTabBar: UITabBar {
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 80
            return sizeThatFits
        }
    }
}


