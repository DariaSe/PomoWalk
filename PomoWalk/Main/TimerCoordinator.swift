//
//  TimerCoordinator.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 06.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class TimerCoordinator {
    let timerVC = MainViewController()
    let timerManager = TimerManager()
    let notificationsManager = NotificationsManager()
    
    var fireDate: Date?
    var startTimeInterval: TimeInterval = 0
    
    func start() {
        timerVC.coordinator = self
        timerManager.delegate = self
        if let intervals = Interval.loadFromFile(),
            !intervals.isEmpty,
            let currentInterval = intervals
                .filter({($0.startDate < Date())&&($0.endDate > Date())})
                .first {
            let endDate = currentInterval.endDate
            fireDate = endDate
            startTimeInterval = currentInterval.duration
            timerManager.startTimer()
        }
        else {
            setDefaultUI()
        }
        
    }
    
    func setDefaultUI() {
        timerVC.activityType = .work
        let workDuration = BaseSettings.workIntervalDuration
        startTimeInterval = TimeInterval(workDuration * 60)
        let timerString = String(format: "%02i : %02i", workDuration, 0)
        timerVC.updateUI(timeString: timerString, percentRemaining: 1.0)
    }
    
    func startTimer() {
        
    }
    
    func stopTimer() {
        
    }
    
    func switchActivityType(currentType: ActivityType) {
        
    }
    
    func startNext() {
        
    }
}

extension TimerCoordinator: TimerDelegate {
    func updateUI() {
        guard let fireDate = fireDate else { return }
        let remainingTimeInterval = (fireDate - Date()).rounded()
        timerVC.updateUI(timeString: remainingTimeInterval.timerString, percentRemaining: CGFloat(remainingTimeInterval / startTimeInterval))
        if remainingTimeInterval <= 0 {
            timerManager.stopTimer()
        }
    }
}
