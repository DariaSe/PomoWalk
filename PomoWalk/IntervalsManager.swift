//
//  IntervalsManager.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 05.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class IntervalsManager {
    
    lazy var workDuration = TimeInterval(BaseSettings.workIntervalDuration * 60)
    lazy var walkDuration = TimeInterval(BaseSettings.walkIntervalDuration * 60)
    
    lazy var workIntervalsCount = BaseSettings.longPauseAfter
    lazy var longPauseDuration = TimeInterval(BaseSettings.longPauseDuration * 60)
    
    func createAllIntervals(startingWith type: ActivityType) -> [Interval] {
        var startDate = Date()
        var intervals = [Interval]()
        if BaseSettings.isAutoContinued {
            if type == .walk {
                let walkInterval = Interval(startDate: startDate, endDate: startDate + walkDuration, activityType: ActivityType.walk.rawValue)
                intervals.append(walkInterval)
                startDate += walkDuration
            }
            if BaseSettings.isLongPausePlanned {
                let workRestUnitsCount = 50 / (workIntervalsCount * 2)
                
                let unitDuration = workDuration * Double(workIntervalsCount) + walkDuration * Double(workIntervalsCount - 1) + longPauseDuration
                for _ in 1...workRestUnitsCount {
                    let unitIntervals = createIntervalsForUnit(startingWith: startDate)
                    intervals.append(contentsOf: unitIntervals)
                    startDate += unitDuration
                }
            }
            else {
                for _ in 1...24 {
                    let workInterval = createInterval(startingWith: startDate, type: .work)
                    intervals.append(workInterval)
                    startDate += workDuration
                    let walkInterval = createInterval(startingWith: startDate, type: .walk)
                    intervals.append(walkInterval)
                    startDate += walkDuration
                }
            }
            if BaseSettings.isPrereminderSet {
                intervals = Array(intervals.prefix(upTo: intervals.count / 2))
            }
        }
        else {
            let interval = createInterval(startingWith: startDate, type: type)
            intervals.append(interval)
        }
        Interval.saveToFile(intervals: intervals)
        return intervals
    }
    
    func createIntervalsForUnit(startingWith date: Date) -> [Interval] {
        var unitIntervals = [Interval]()
        var startDate = date
        for _ in 1...workIntervalsCount - 1 {
            let workInterval = createInterval(startingWith: startDate, type: .work)
            unitIntervals.append(workInterval)
            startDate += workDuration
            let walkInterval = createInterval(startingWith: startDate, type: .walk)
            unitIntervals.append(walkInterval)
            startDate += walkDuration
        }
        let lastWorkInterval = createInterval(startingWith: startDate, type: .work)
        unitIntervals.append(lastWorkInterval)
        startDate += workDuration
        let longPauseInterval = createInterval(startingWith: startDate, type: .longPause)
        unitIntervals.append(longPauseInterval)
        return unitIntervals
    }
    
    func createInterval(startingWith date: Date, type: ActivityType) -> Interval {
        let start = date
        var duration: TimeInterval
        switch type {
        case .work: duration = workDuration
        case .walk: duration = walkDuration
        case .longPause: duration = longPauseDuration
        }
        let end = date + duration
        let interval = Interval(startDate: start, endDate: end, activityType: type.rawValue)
        return interval
    }
}
