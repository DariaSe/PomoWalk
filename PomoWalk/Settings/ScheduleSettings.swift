//
//  ScheduleSettings.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 14.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class ScheduleSettings {
    
    static let defaults = UserDefaults.standard
    
    // MARK: - Values
    
    static var isScheduled: Bool {
        get { defaults.bool(forKey: isScheduledKey) }
        set(newValue) { defaults.set(newValue, forKey: isScheduledKey)} }
    
    
    static var scheduleStartHour: Int {
        get { defaults.integer(forKey: scheduleStartHourKey) }
        set(newValue) { defaults.set(newValue, forKey: scheduleStartHourKey)} }
    
    static var scheduleStartMinute: Int {
        get { defaults.integer(forKey: scheduleStartMinuteKey) }
        set(newValue) { defaults.set(newValue, forKey: scheduleStartMinuteKey)} }
    
    static var scheduleEndHour: Int {
        get { defaults.integer(forKey: scheduleEndHourKey) }
        set(newValue) { defaults.set(newValue, forKey: scheduleEndHourKey)} }
    
    static var scheduleEndMinute: Int {
        get { defaults.integer(forKey: scheduleEndMinuteKey) }
        set(newValue) { defaults.set(newValue, forKey: scheduleEndMinuteKey)} }
    
    
    static var isLunchPlanned: Bool {
        get { defaults.bool(forKey: isLunchPlannedKey) }
        set(newValue) { defaults.set(newValue, forKey: isLunchPlannedKey)} }
    
    
    static var lunchStartHour: Int {
        get { defaults.integer(forKey: lunchStartHourKey) }
        set(newValue) { defaults.set(newValue, forKey: lunchStartHourKey)} }
    
    static var lunchStartMinute: Int {
        get { defaults.integer(forKey: lunchStartMinuteKey) }
        set(newValue) { defaults.set(newValue, forKey: lunchStartMinuteKey)} }
    
    static var lunchEndHour: Int {
        get { defaults.integer(forKey: lunchEndHourKey) }
        set(newValue) { defaults.set(newValue, forKey: lunchEndHourKey)} }
    
    static var lunchEndMinute: Int {
        get { defaults.integer(forKey: lunchEndMinuteKey) }
        set(newValue) { defaults.set(newValue, forKey: lunchEndMinuteKey)} }
    
    
    
    // MARK: - Keys
    
    private static let isScheduledKey = "isScheduledKey"
    
    private static let scheduleStartHourKey = "scheduleStartHour"
    private static let scheduleStartMinuteKey = "scheduleStartMinute"
    private static let scheduleEndHourKey = "scheduleEndHour"
    private static let scheduleEndMinuteKey = "scheduleEndMinute"
    
    private static let isLunchPlannedKey = "isLunchPlannedKey"
    
    private static let lunchStartHourKey = "lunchStartHour"
    private static let lunchStartMinuteKey = "lunchStartMinute"
    private static let lunchEndHourKey = "lunchEndHour"
    private static let lunchEndMinuteKey = "lunchEndMinute"
    
    // MARK: - Setting default values
    
    static func setDefault() {
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
        
        
        if defaults.value(forKey: isLunchPlannedKey) == nil {
            defaults.set(true, forKey: isLunchPlannedKey)
        }
        
        
        if defaults.value(forKey: lunchStartHourKey) == nil {
            defaults.set(13, forKey: lunchStartHourKey)
        }
        if defaults.value(forKey: lunchStartMinuteKey) == nil {
            defaults.set(0, forKey: lunchStartMinuteKey)
        }
        if defaults.value(forKey: lunchEndHourKey) == nil {
            defaults.set(14, forKey: lunchEndHourKey)
        }
        if defaults.value(forKey: lunchEndMinuteKey) == nil {
            defaults.set(0, forKey: lunchEndMinuteKey)
        }
    }
}
