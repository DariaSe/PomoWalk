//
//  MainTabBarController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 13.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let timerCoordinator = TimerCoordinator()
    
    let historyCoordinator = HistoryCoordinator()
    
    let badgesCoordinator = BadgesCoordinator()
    
    let settingsVC = SettingsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        timerCoordinator.start()
        timerCoordinator.timerVC.tabBarItem = UITabBarItem(title: Strings.timer, image: UIImage(named: "TimerTabIcon"), tag: 0)
        historyCoordinator.historyVC.tabBarItem = UITabBarItem(title: Strings.history, image: UIImage(named: "History"), tag: 1)
        historyCoordinator.start()
        badgesCoordinator.badgesVC.tabBarItem = UITabBarItem(title: Strings.badges, image: UIImage(named: "Badges"), tag: 2)
        badgesCoordinator.start()
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: UIImage(named: "Settings"), tag: 3)
        self.viewControllers = [timerCoordinator.timerVC, historyCoordinator.historyVC, badgesCoordinator.badgesVC, settingsVC]
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = UIColor.textColor
        tabBar.backgroundColor = UIColor.backgroundColor
        tabBar.barTintColor = UIColor.backgroundColor
    }
}
