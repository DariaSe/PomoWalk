//
//  AppDelegate.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 09.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Settings.setDefault()
        
        let tabBarVC = MainTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
        notificationCenter.delegate = self
        
        return true
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
