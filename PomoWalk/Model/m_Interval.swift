//
//  m_Interval.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 05.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation
import CoreMotion

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
            print("get steps")
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
    
    func getSteps(from pedometer: CMPedometer, completion: @escaping (Int) -> Void) {
        guard CMPedometer.isStepCountingAvailable() else { return }
        pedometer.queryPedometerData(from: startDate, to: endDate) { (data, error) in
            guard let data = data, error == nil else { return }
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
