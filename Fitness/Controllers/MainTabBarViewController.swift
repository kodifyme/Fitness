//
//  MainTabBarViewController.swift
//  Fitness
//
//  Created by KODDER on 12.12.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
        
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: StatisticViewController())
        
        vc1.tabBarItem.image = UIImage(named: "tabBarMain")
        vc2.tabBarItem.image = UIImage(named: "tabBarStatistic")
        
        vc1.title = "Main"
        vc2.title = "Statistics"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    }
}
