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

    override func viewDidLoad() {
        super.viewDidLoad()
        timerCoordinator.start()
        timerCoordinator.timerVC.tabBarItem = UITabBarItem(title: Strings.timer, image: UIImage(named: "TimerTabIcon"), tag: 0)
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: UIImage(named: "SettingsTabIcon"), tag: 1)
        self.viewControllers = [timerCoordinator.timerVC, settingsVC]
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = UIColor.textColor
        tabBar.backgroundColor = UIColor.backgroundColor
        tabBar.barTintColor = UIColor.backgroundColor
    }
}
