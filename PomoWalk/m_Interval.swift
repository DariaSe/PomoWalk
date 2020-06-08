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
    
    // MARK: - Coding and encoding
    
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var ArchiveURL = documentsDirectory.appendingPathComponent("intervals").appendingPathExtension("plist")
    
    static func saveToFile(intervals: [Interval]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedIntervals = try? propertyListEncoder.encode(intervals)
        try? encodedIntervals?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Interval]? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedIntervalsData = try? Data(contentsOf: ArchiveURL) else { return nil }
        return try? propertyListDecoder.decode(Array<Interval>.self, from: retrievedIntervalsData)
    }
}
