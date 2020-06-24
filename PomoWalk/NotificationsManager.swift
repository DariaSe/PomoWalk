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
    
    let dateFormatter = DateFormatter()
    
    func scheduleNotifications(startingWith type: ActivityType) {
        let intervals = intervalsManager.createAllIntervals(startingWith: type)
        for (index, interval) in intervals.enumerated() {
            if BaseSettings.isPrereminderSet {
                schedulePrereminder(for: interval, index: index)
            }
            if index < intervals.count - 1 {
                scheduleNotification(for: interval, nextInterval: intervals[index + 1], index: index)
            }
            else {
                scheduleNotification(for: interval, nextInterval: nil, index: index)
            }
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
    
    private func scheduleNotification(for interval: Interval, nextInterval: Interval?, index: Int) {
        var text: String
        var soundName: String
        let activityType = ActivityType(rawValue: interval.activityType)!
        switch activityType {
        case .work:
            soundName = SoundColorSettings.workEndSound + ".wav"
        default:
            soundName = SoundColorSettings.walkEndSound + ".wav"
        }
        if let nextInterval = nextInterval {
            let nextActivityType = ActivityType(rawValue: nextInterval.activityType)!
            switch nextActivityType {
            case .work:
                text = Strings.goWork + "\n" + Strings.workUntil
            case .walk:
                text = Strings.goWalk + "\n" + Strings.walkUntil
            case .longPause:
                text = Strings.longPause + "\n" + Strings.walkUntil
            }
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            let timeString = dateFormatter.string(from: nextInterval.endDate)
            text += timeString + "."
        }
        else {
            text = Strings.launchApp
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
