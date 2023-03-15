//
//  TabBarViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    func setUpTabBar() {
        let animalListView = ViewController()
        let homeView = HomeViewController()
        let fishView = ViewController()

        animalListView.tabBarItem = UITabBarItem(title: "주민",
                                                 image: UIImage(systemName: "pawprint"),
                                                 selectedImage: UIImage(systemName: "pawprint.fill"))
        homeView.tabBarItem = UITabBarItem(title: "홈",
                                                 image: UIImage(systemName: "house"),
                                                 selectedImage: UIImage(systemName: "house.fill"))
        
        fishView.tabBarItem = UITabBarItem(title: "물고기/곤충도감",
                                                 image: UIImage(systemName: "text.book.closed"),
                                                 selectedImage: UIImage(systemName: "text.book.closed.fill"))
        
        
        animalListView.navigationItem.largeTitleDisplayMode = .always
        homeView.navigationItem.largeTitleDisplayMode = .always
        fishView.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: animalListView)
        let home = UINavigationController(rootViewController: homeView)
        let nav2 = UINavigationController(rootViewController: fishView)
        
        nav1.navigationBar.prefersLargeTitles = true
        home.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1,home,nav2], animated: false)
        
        //투명도 해제
        tabBar.isTranslucent = false
    }


}
