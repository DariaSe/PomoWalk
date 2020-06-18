//
//  m_Interval.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 05.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

enum ActivityType: String {
    case work
    case walk
    case longPause
}

struct Interval: Codable {
    var startDate: Date
    var endDate: Date
    var activityType: String
    
    var duration: TimeInterval {
        let type = ActivityType(rawValue: activityType)!
        switch type {
        case .work: return TimeInterval(BaseSettings.workIntervalDuration * 60)
        case .walk: return TimeInterval(BaseSettings.walkIntervalDuration * 60)
        case .longPause: return TimeInterval(BaseSettings.longPauseDuration * 60)
        }
    }
    
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
        if var savedFinished = Interval.loadFinishedFromFile() {
            savedFinished.append(contentsOf: finishedIntervals)
            Interval.saveFinishedToFile(intervals: savedFinished)
        }
        else {
            Interval.saveFinishedToFile(intervals: finishedIntervals)
        }
    }
}
