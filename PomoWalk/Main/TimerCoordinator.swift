//
//  TimerCoordinator.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 06.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import CoreMotion

class TimerCoordinator: NSObject {
    
    let timerVC = MainViewController()
    let timerManager = TimerManager()
    let notificationsManager = NotificationsManager()
    
    let pedometer = CMPedometer()
    
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
        showTotalSteps()
        if let intervals = Interval.loadAllFromFile(), !intervals.isEmpty {
            if let currentInterval = intervals
                .filter({($0.startDate < (Date() + 1))&&($0.endDate > Date())}).first {
                fireDate = currentInterval.endDate
                startTimeInterval = currentInterval.duration
                activityType = ActivityType(rawValue: currentInterval.activityType)!
                timerManager.startTimer()
                timerVC.isTimerRunning = true
            }
            else {
                setDefaultUI()
                Interval.filterAndSaveFinished(from: intervals)
            }
        }
        else {
            setDefaultUI()
        }
        UserDefaults.standard.addObserver(self, forKeyPath: BaseSettings.workIntervalDurationKey, options: .new, context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: BaseSettings.walkIntervalDurationKey, options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        stopTimer()
        setDefaultUI()
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
        
        showCurrentSteps()
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
        if let intervals = Interval.loadAllFromFile() {
            Interval.filterAndSaveFinished(from: intervals)
        }
        timerManager.stopTimer()
        fireDate = nil
        timerVC.isTimerRunning = false
        let timerString = startTimeInterval.timerString
        timerVC.updateUI(timeString: timerString, percentRemaining: 1.0)
        Interval.saveAllToFile(intervals: [])
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        pedometer.stopUpdates()
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
        Interval.saveAllToFile(intervals: [])
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func startNext() {
        pedometer.stopUpdates()
        timerVC.currentStepsLabel.text = Strings.steps + "0"
        if let interval = Interval.current() {
            fireDate = interval.endDate
            startTimeInterval = interval.duration
            activityType = ActivityType(rawValue: interval.activityType)!
            timerManager.startTimer()
            showCurrentSteps()
        }
    }
    
    func showCurrentSteps() {
        if activityType != .work, CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [unowned self] (data, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.timerVC.currentStepsLabel.text = Strings.steps + String(Int(truncating: data.numberOfSteps))
                    self.showTotalSteps()
                }
            }
        }
    }
    
    func showTotalSteps() {
        guard CMPedometer.isStepCountingAvailable() else { return }
        let calendar = Calendar.current
        pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { [unowned self] (data, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.timerVC.totalStepsLabel.text = Strings.stepsToday + String(Int(truncating: data.numberOfSteps))
            }
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
