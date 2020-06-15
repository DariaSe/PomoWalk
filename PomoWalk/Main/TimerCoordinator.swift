//
//  TimerCoordinator.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 06.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class TimerCoordinator: NSObject {
    
    let timerVC = MainViewController()
    let timerManager = TimerManager()
    let notificationsManager = NotificationsManager()
    
    var fireDate: Date?
    var startTimeInterval: TimeInterval = 0 {
        didSet {
            let timerString = startTimeInterval.timerString
            timerVC.updateUI(timeString: timerString, percentRemaining: 1.0)
        }
    }
    
    var activityType: ActivityType = .work {
        didSet {
            timerVC.activityType = activityType
        }
    }
    
    func start() {
        timerVC.coordinator = self
        timerManager.delegate = self
        if let interval = Interval.current() {
            fireDate = interval.endDate
            startTimeInterval = interval.duration
            activityType = ActivityType(rawValue: interval.activityType)!
            timerManager.startTimer()
            timerVC.isTimerRunning = true
        }
        else {
            setDefaultUI()
        }
    }
   
    func setDefaultUI() {
        activityType = .work
        let workDuration = BaseSettings.workIntervalDuration
        startTimeInterval = TimeInterval(workDuration * 60)
        timerVC.isTimerRunning = false
    }
    
    func startOrStopTimer() {
        if timerManager.timer == nil {
            startTimer()
        }
        else {
            alertStop()
        }
    }
    
    func startTimer() {
        fireDate = Date() + startTimeInterval
        timerManager.startTimer()
        timerVC.isTimerRunning = true
        notificationsManager.scheduleNotifications(startingWith: activityType)
    }
    
    func alertStop() {
        let alert = UIAlertController(title: Strings.stopQuestion, message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: Strings.yes, style: .destructive) { [unowned self] (_) in
            self.stopTimer()
        }
        let no = UIAlertAction(title: Strings.no, style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        timerVC.present(alert, animated: true)
    }
    
    func stopTimer() {
        timerManager.stopTimer()
        fireDate = nil
        timerVC.isTimerRunning = false
        let timerString = startTimeInterval.timerString
        timerVC.updateUI(timeString: timerString, percentRemaining: 1.0)
        Interval.saveToFile(intervals: [])
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
   
    func alertSwitchActivityType(currentType: ActivityType) {
        if timerManager.timer != nil {
            var walkOrWork: String
            switch activityType {
            case .work: walkOrWork = Strings.switchToWalk
            default: walkOrWork = Strings.switchToWork
            }
            let alert = UIAlertController(title: Strings.switchActivityQuestion + walkOrWork, message: nil, preferredStyle: .alert)
            let yes = UIAlertAction(title: Strings.yes, style: .destructive) { [unowned self] (_) in
                self.stopTimer()
                self.switchActivityType()
            }
            let no = UIAlertAction(title: Strings.no, style: .cancel, handler: nil)
            alert.addAction(yes)
            alert.addAction(no)
            timerVC.present(alert, animated: true)
        }
        else {
            switchActivityType()
        }
    }
    
    func switchActivityType() {
        if activityType == .work {
            activityType = .walk
            let walkDuration = BaseSettings.walkIntervalDuration
            startTimeInterval = TimeInterval(walkDuration * 60)
        }
        else {
            activityType = .work
            let workDuration = BaseSettings.workIntervalDuration
            startTimeInterval = TimeInterval(workDuration * 60)
        }
        Interval.saveToFile(intervals: [])
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func startNext() {
        if let interval = Interval.current() {
            fireDate = interval.endDate
            startTimeInterval = interval.duration
            activityType = ActivityType(rawValue: interval.activityType)!
            timerManager.startTimer()
        }
    }
}

extension TimerCoordinator: TimerDelegate {
    func updateUI() {
        guard let fireDate = fireDate else { return }
        let remainingTimeInterval = (fireDate - Date()).rounded()
        let timerString = remainingTimeInterval.timerString
        let percent = CGFloat(remainingTimeInterval / startTimeInterval)
        timerVC.updateUI(timeString: timerString, percentRemaining: percent)
        if remainingTimeInterval <= 0 {
            timerManager.stopTimer()
            if BaseSettings.isAutoContinued {
                startNext()
            }
            else {
                stopTimer()
            }
        }
    }
}
