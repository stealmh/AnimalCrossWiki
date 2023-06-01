//
//  TabBarViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit


class TabBarViewController: UITabBarController {
    
    private let citizenCoordinator = CitizenCoordinator()
    private let turnipCoordinator = TurnipCoordinator()
    private let creatureCoordinator = CreatureCoordinator()
    
    private var citizenViewController: UIViewController {
        return citizenCoordinator.rootViewController
    }
    private var creatureViewController: UIViewController {
        return creatureCoordinator.rootViewController
    }
    private var turnipViewController: UIViewController {
        return turnipCoordinator.rootViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .black
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        } else {
            tabBar.barTintColor = .black
        }

        citizenViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        creatureViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 1)
        turnipViewController.tabBarItem = UITabBarItem(title: "무 가격", image: UIImage(named: "turnip")!.withRenderingMode(.alwaysOriginal), tag: 2)
        
        citizenCoordinator.start()
        creatureCoordinator.start()
        turnipCoordinator.start()
        self.changeRadius(cornerRadius: 40)
        self.setSelectedItemColor(selectedColor: .white, unSelectedcolor: .black)
        
        self.viewControllers = [citizenViewController,
                                creatureViewController,
                                turnipViewController]
    }
}

// MARK: - Method
extension TabBarViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.changedHeightOfTabBar(setHeight: 80)
    }
    
    private func changedHeightOfTabBar(setHeight: Double) {
//        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame = tabBar.frame
            tabFrame.size.height = setHeight
            tabFrame.origin.y = view.frame.size.height - setHeight
            tabBar.frame = tabFrame
//        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.annimationWhenSelectItem(item)
    }
    
    private func annimationWhenSelectItem(_ item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 0.5
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
    private func setSelectedItemColor(selectedColor: UIColor? ,unSelectedcolor: UIColor?) {
        self.tabBar.unselectedItemTintColor = unSelectedcolor ?? .black
        tabBar.tintColor = selectedColor ?? .white
    }
    
    private func changeRadius(cornerRadius: CGFloat) {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = cornerRadius
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}


