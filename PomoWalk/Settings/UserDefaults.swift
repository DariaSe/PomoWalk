//
//  UserDefaults.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 10.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class Settings {
    
    static let defaults = UserDefaults.standard
    
    // MARK: - Values
    
    static var workIntervalDuration: Int { defaults.integer(forKey: workIntervalDurationKey) }
    static var walkIntervalDuration: Int { defaults.integer(forKey: walkIntervalDurationKey) }
    
    static var isLongPausePlanned: Bool { defaults.bool(forKey: isLongPausePlannedKey) }
    static var longPauseDuration: Int { defaults.integer(forKey: longPauseDurationKey) }
    static var longPauseAfter: Int { defaults.integer(forKey: longPauseAfterKey) }
    
    static var isAutoContinued: Bool { defaults.bool(forKey: isAutoContinuedKey) }
    
    static var isScheduled: Bool { defaults.bool(forKey: isScheduledKey) }
    static var scheduleStartHour: Int { defaults.integer(forKey: scheduleStartHourKey) }
    static var scheduleStartMinute: Int { defaults.integer(forKey: scheduleStartMinuteKey) }
    static var scheduleEndHour: Int { defaults.integer(forKey: scheduleEndHourKey) }
    static var scheduleEndMinute: Int { defaults.integer(forKey: scheduleEndMinuteKey) }
    
    static var isPrereminderSet: Bool { defaults.bool(forKey: isPrereminderSetKey)}
    static var isVibrationOn: Bool { defaults.bool(forKey: isVibrationOnKey)}

    static var colorScheme: Int { defaults.integer(forKey: colorSchemeKey) }

    
    // MARK: - Keys
   
    static let workIntervalDurationKey = "workIntervalDuration"
    static let walkIntervalDurationKey = "walkIntervalDuration"
    
    static let isLongPausePlannedKey = "isLongPausePlanned"
    static let longPauseDurationKey = "longPauseDuration"
    static let longPauseAfterKey = "longPauseAfter"
    
    static let isAutoContinuedKey = "isAutoContinued"
    
    static let isScheduledKey = "isScheduledKey"
    static let scheduleStartHourKey = "scheduleStartHour"
    static let scheduleStartMinuteKey = "scheduleStartMinute"
    static let scheduleEndHourKey = "scheduleEndHour"
    static let scheduleEndMinuteKey = "scheduleEndMinute"
    
    static let isPrereminderSetKey = "isPrereminderSet"
    static let isVibrationOnKey = "isVibrationOn"
    
    static let colorSchemeKey = "colorScheme"
    
    // MARK: - Setting default values
    // call in AppDelegate on start
    
    static func setDefault() {
        if defaults.value(forKey: workIntervalDurationKey) == nil {
            defaults.set(30, forKey: workIntervalDurationKey)
        }
        if defaults.value(forKey: walkIntervalDurationKey) == nil {
            defaults.set(5, forKey: walkIntervalDurationKey)
        }
        if defaults.value(forKey: isLongPausePlannedKey) == nil {
            defaults.set(true, forKey: isLongPausePlannedKey)
        }
        if defaults.value(forKey: longPauseDurationKey) == nil {
            defaults.set(10, forKey: longPauseDurationKey)
        }
        if defaults.value(forKey: longPauseAfterKey) == nil {
            defaults.set(3, forKey: longPauseAfterKey)
        }
        if defaults.value(forKey: isAutoContinuedKey) == nil {
            defaults.set(true, forKey: isAutoContinuedKey)
        }
        if defaults.value(forKey: isScheduledKey) == nil {
            defaults.set(false, forKey: isScheduledKey)
        }
        if defaults.value(forKey: scheduleStartHourKey) == nil {
            defaults.set(9, forKey: scheduleStartHourKey)
        }
        if defaults.value(forKey: scheduleStartMinuteKey) == nil {
            defaults.set(0, forKey: scheduleStartMinuteKey)
        }
        if defaults.value(forKey: scheduleEndHourKey) == nil {
            defaults.set(17, forKey: scheduleEndHourKey)
        }
        if defaults.value(forKey: scheduleEndMinuteKey) == nil {
            defaults.set(0, forKey: scheduleEndMinuteKey)
        }
        if defaults.value(forKey: isPrereminderSetKey) == nil {
            defaults.set(true, forKey: isPrereminderSetKey)
        }
        if defaults.value(forKey: isVibrationOnKey) == nil {
            defaults.set(true, forKey: isVibrationOnKey)
        }
        if defaults.value(forKey: colorSchemeKey) == nil {
            defaults.set(2, forKey: colorSchemeKey)
        }
    }
    
}
