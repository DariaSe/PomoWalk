//
//  m_Interval.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 05.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation
import CoreMotion
import HealthKit

enum ActivityType: String {
    case work
    case walk
    case longPause
}

struct Interval: Codable {
    var startDate: Date
    var endDate: Date
    var activityType: String
    var task: String?
    var steps: Int?
    
    var duration: TimeInterval {
        let type = ActivityType(rawValue: activityType)!
        switch type {
        case .work: return TimeInterval(BaseSettings.workIntervalDuration * 60)
        case .walk: return TimeInterval(BaseSettings.walkIntervalDuration * 60)
        case .longPause: return TimeInterval(BaseSettings.longPauseDuration * 60)
        }
    }
    
    static func historySamples() -> [[Interval]] {
        let date = Date() - 22500
        let yesterday = date - 86400 - 16500
        let yesterdayfirstPomEnd = yesterday + 1800
        let yesterdayfirstRestEnd = yesterdayfirstPomEnd + 300
        let yesterdaysecondPomEnd = yesterdayfirstRestEnd + 1800
        let yesterdaysecondRestEnd = yesterdaysecondPomEnd + 300
        let yesterdaythirdPomEnd = yesterdaysecondRestEnd + 1800
        let yesterdaylongPauseEnd = yesterdaythirdPomEnd + 600
        let yesterdayFourthPomEnd = yesterdaylongPauseEnd + 1800
        
        let firstPomEnd = date + 1800
        let firstRestEnd = firstPomEnd + 300
        let secondPomEnd = firstRestEnd + 1800
        let secondRestEnd = secondPomEnd + 300
        let thirdPomEnd = secondRestEnd + 1800
        return [
            [Interval(startDate: yesterday, endDate: yesterdayfirstPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task1, steps: 2),
            Interval(startDate: yesterdayfirstPomEnd, endDate: yesterdayfirstRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 443),
            Interval(startDate: yesterdayfirstRestEnd, endDate: yesterdaysecondPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task1, steps: 3),
            Interval(startDate: yesterdaysecondPomEnd, endDate: yesterdaysecondRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 378),
            Interval(startDate: yesterdaysecondRestEnd, endDate: yesterdaythirdPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task2, steps: 1),
            Interval(startDate: yesterdaythirdPomEnd, endDate: yesterdaylongPauseEnd, activityType: ActivityType.longPause.rawValue, task: nil, steps: 872),
            Interval(startDate: yesterdaylongPauseEnd, endDate: yesterdayFourthPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task3, steps: 2)],
            
            [Interval(startDate: date, endDate: firstPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task3, steps: 2),
            Interval(startDate: firstPomEnd, endDate: firstRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 443),
            Interval(startDate: firstRestEnd, endDate: secondPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task2, steps: 3),
            Interval(startDate: secondPomEnd, endDate: secondRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 378),
            Interval(startDate: secondRestEnd, endDate: thirdPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task1, steps: 1)]
        ]
    }
    
    static func badgesSamples() -> [Interval] {
        let date = Date() - 22500
        let yesterday = date - 86400 - 16500
        let yesterdayfirstPomEnd = yesterday + 1800
        let yesterdayfirstRestEnd = yesterdayfirstPomEnd + 300
        let yesterdaysecondPomEnd = yesterdayfirstRestEnd + 1800
        let yesterdaysecondRestEnd = yesterdaysecondPomEnd + 300
        let yesterdaythirdPomEnd = yesterdaysecondRestEnd + 1800
        let yesterdaylongPauseEnd = yesterdaythirdPomEnd + 600
        let yesterdayFourthPomEnd = yesterdaylongPauseEnd + 1800
        
        let firstPomEnd = date + 1800
        let firstRestEnd = firstPomEnd + 300
        let secondPomEnd = firstRestEnd + 1800
        let secondRestEnd = secondPomEnd + 300
        let thirdPomEnd = secondRestEnd + 1800
        return [
            Interval(startDate: yesterday, endDate: yesterdayfirstPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task1, steps: 2),
            Interval(startDate: yesterdayfirstPomEnd, endDate: yesterdayfirstRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 443),
            Interval(startDate: yesterdayfirstRestEnd, endDate: yesterdaysecondPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task1, steps: 3),
            Interval(startDate: yesterdaysecondPomEnd, endDate: yesterdaysecondRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 378),
            Interval(startDate: yesterdaysecondRestEnd, endDate: yesterdaythirdPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task2, steps: 1),
            Interval(startDate: yesterdaythirdPomEnd, endDate: yesterdaylongPauseEnd, activityType: ActivityType.longPause.rawValue, task: nil, steps: 872),
            Interval(startDate: yesterdaylongPauseEnd, endDate: yesterdayFourthPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task3, steps: 2),
            
            Interval(startDate: date, endDate: firstPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task3, steps: 2),
            Interval(startDate: firstPomEnd, endDate: firstRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 443),
            Interval(startDate: firstRestEnd, endDate: secondPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task2, steps: 3),
            Interval(startDate: secondPomEnd, endDate: secondRestEnd, activityType: ActivityType.walk.rawValue, task: nil, steps: 378),
            Interval(startDate: secondRestEnd, endDate: thirdPomEnd, activityType: ActivityType.work.rawValue, task: Strings.task1, steps: 1)
        ]
    }
    
    static let pedometer = CMPedometer()
    
    static func current() -> Interval? {
        if let intervals = Interval.loadAllFromFile(),
            !intervals.isEmpty,
            let currentInterval = intervals
                .filter({($0.startDate < (Date() + 1))&&($0.endDate > Date())})
                .first {
            return currentInterval
        }
        else {
            return nil
        }
    }
    
    func withTask(_ task: String) -> Interval {
        var interval = self
        interval.task = task
        return interval
    }
    
    // MARK: - Coding and encoding
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("intervals").appendingPathExtension("plist")
    static let finishedArchiveURL = documentsDirectory.appendingPathComponent("finishedIntervals").appendingPathExtension("plist")
    
    static func saveAllToFile(intervals: [Interval]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedIntervals = try? propertyListEncoder.encode(intervals)
        try? encodedIntervals?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func saveFinishedToFile(intervals: [Interval]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedIntervals = try? propertyListEncoder.encode(intervals)
        try? encodedIntervals?.write(to: finishedArchiveURL, options: .noFileProtection)
    }
    
    static func loadAllFromFile() -> [Interval]? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedIntervalsData = try? Data(contentsOf: archiveURL) else { return nil }
        return try? propertyListDecoder.decode(Array<Interval>.self, from: retrievedIntervalsData)
    }
    
    static func loadFinishedFromFile() -> [Interval]? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedIntervalsData = try? Data(contentsOf: finishedArchiveURL) else { return nil }
        return try? propertyListDecoder.decode(Array<Interval>.self, from: retrievedIntervalsData)
    }
    
    static func filterAndSaveFinished(from intervals: [Interval]) {
        let finishedIntervals = intervals.filter { ($0.endDate < Date()) }
        getStepsForIntervals(intervals: finishedIntervals, from: pedometer) { (intervals) in
            if let savedFinished = Interval.loadFinishedFromFile() {
                Interval.saveFinishedToFile(intervals: savedFinished + intervals)
            }
            else {
                Interval.saveFinishedToFile(intervals: intervals)
            }
        }
    }
    
    static func getStepsForIntervals(intervals: [Interval], from pedometer: CMPedometer, completion: @escaping ([Interval]) -> Void) {
        guard !intervals.isEmpty else { completion([]); return }
        var intervalsWithSteps = [Interval]()
        var count = 0
        for interval in intervals {
            var newInterval = interval
            newInterval.getSteps(from: pedometer) { (stepsNumber) in
                newInterval.steps = stepsNumber
                intervalsWithSteps.append(newInterval)
                count += 1
                if count == intervals.count {
                    completion(intervalsWithSteps)
                }
            }
        }
    }
    
    func getSteps(from pedometer: CMPedometer, completion: @escaping (Int?) -> Void) {
        guard CMPedometer.isStepCountingAvailable() else { completion(nil); return }
        pedometer.queryPedometerData(from: startDate, to: endDate) { (data, error) in
            guard let data = data, error == nil else { completion(nil); return }
            completion(Int(truncating: data.numberOfSteps))
        }
    }
}

extension Interval: Comparable, Equatable {
    static func <(lhs: Interval, rhs: Interval) -> Bool {
        return lhs.endDate < rhs.endDate
    }
    static func ==(lhs: Interval, rhs: Interval) -> Bool {
        return lhs.endDate == rhs.endDate
    }
}
