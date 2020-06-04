//
//  MainTabBarController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 13.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(title: Strings.timer, image: UIImage(named: "TimerTabIcon"), tag: 0)
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: Strings.settings, image: UIImage(named: "SettingsTabIcon"), tag: 1)
        self.viewControllers = [mainVC, settingsVC]
        
    }
    

   

}
