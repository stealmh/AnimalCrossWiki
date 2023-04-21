//
//  TabBarViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //View 1
//        let animalListView = ViewController()
        
        let animalListView = CitizenViewController()
        
        //View 2
        let layout = UICollectionViewFlowLayout()
//        let homeView = HomeViewController()
        let homeView = BugViewController()
        
        //View 3
        let fishView = FishViewController()

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
        fishView.navigationItem.largeTitleDisplayMode = .never
        
        let nav1 = UINavigationController(rootViewController: animalListView)
        let home = UINavigationController(rootViewController: homeView)
//        UINavigationBar.appearance().barTintColor = UIColor.red
        let nav2 = UINavigationController(rootViewController: fishView)
        
        nav1.navigationBar.prefersLargeTitles = false
        home.navigationBar.prefersLargeTitles = false
        nav2.navigationBar.prefersLargeTitles = false
        
//        setViewControllers([nav1,home,nav2], animated: false)
        self.viewControllers = [nav1,home,nav2]
        
        //투명도 해제
        tabBar.isTranslucent = true
    }
    
    
    
    func setUpTabBar() {
    }


}
