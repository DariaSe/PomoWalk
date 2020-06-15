//
//  BaseSettings.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 14.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class BaseSettings {
    
    static let defaults = UserDefaults.standard
    
    // MARK: - Values
    
    static var workIntervalDuration: Int {
        get { defaults.integer(forKey: workIntervalDurationKey) }
        set(newValue) { defaults.set(newValue, forKey: workIntervalDurationKey)} }
    
    static var walkIntervalDuration: Int {
        get { defaults.integer(forKey: walkIntervalDurationKey) }
        set(newValue) { defaults.set(newValue, forKey: walkIntervalDurationKey)} }
    
    static var isLongPausePlanned: Bool {
        get { defaults.bool(forKey: isLongPausePlannedKey) }
        set(newValue) { defaults.set(newValue, forKey: isLongPausePlannedKey)} }
    
    static var longPauseDuration: Int {
        get { defaults.integer(forKey: longPauseDurationKey) }
        set(newValue) { defaults.set(newValue, forKey: longPauseDurationKey)} }
    
    static var longPauseAfter: Int {
        get { defaults.integer(forKey: longPauseAfterKey) }
        set(newValue) { defaults.set(newValue, forKey: longPauseAfterKey)} }
    
    static var isPrereminderSet: Bool {
        get { defaults.bool(forKey: isPrereminderSetKey)}
        set(newValue) { defaults.set(newValue, forKey: isPrereminderSetKey)} }
    
    static var isAutoContinued: Bool {
        get { defaults.bool(forKey: isAutoContinuedKey) }
        set(newValue) { defaults.set(newValue, forKey: isAutoContinuedKey)} }
    
    
    // MARK: - Keys
    
    static let workIntervalDurationKey = "workIntervalDuration"
    static let walkIntervalDurationKey = "walkIntervalDuration"
    
    static let isLongPausePlannedKey = "isLongPausePlanned"
    static let longPauseDurationKey = "longPauseDuration"
    static let longPauseAfterKey = "longPauseAfter"
    
    static let isPrereminderSetKey = "isPrereminderSet"
    
    static let isAutoContinuedKey = "isAutoContinued"
    
    // MARK: - Setting default values
    
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
        if defaults.value(forKey: isPrereminderSetKey) == nil {
            defaults.set(true, forKey: isPrereminderSetKey)
        }
        if defaults.value(forKey: isAutoContinuedKey) == nil {
            defaults.set(true, forKey: isAutoContinuedKey)
        }
    }
    
}
