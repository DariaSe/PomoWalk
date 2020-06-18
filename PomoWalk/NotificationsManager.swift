//
//  NotificationsManager.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 06.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class NotificationsManager {
    
    let intervalsManager = IntervalsManager()
    
    func scheduleNotifications(startingWith type: ActivityType) {
        let intervals = intervalsManager.createAllIntervals(startingWith: type)
        for (index, interval) in intervals.enumerated() {
            if BaseSettings.isPrereminderSet {
                schedulePrereminder(for: interval, index: index)
            }
            scheduleNotification(for: interval, index: index)
        }
    }
    
    private func schedulePrereminder(for interval: Interval, index: Int) {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName("bell.wav"))
        let prereminderFireDate = interval.endDate - 60
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: prereminderFireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let identifier = "Prereminder\(index)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    private func scheduleNotification(for interval: Interval, index: Int) {
        let activityType = ActivityType(rawValue: interval.activityType)!
        var text: String
        var soundName: String
        switch activityType {
        case .work:
            text = Strings.goWalk
            soundName = SoundColorSettings.workEndSound + ".wav"
        case .walk, .longPause:
            text = Strings.goWork
            soundName = SoundColorSettings.walkEndSound + ".wav"
        }
        let content = UNMutableNotificationContent()
        content.title = Strings.timeIsUp
        content.body = text
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(soundName))
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: interval.endDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let identifier = "Notification\(index)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
