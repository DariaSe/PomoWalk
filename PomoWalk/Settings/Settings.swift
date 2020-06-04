//
//  Settings.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class Settings {
    
    static let defaults = UserDefaults.standard
    
    // MARK: - Values
    
    static var isVibrationOn: Bool {
        get { defaults.bool(forKey: isVibrationOnKey)}
        set(newValue) { defaults.set(newValue, forKey: isVibrationOnKey)} }
    
    
    static var colorScheme: Int {
        get { defaults.integer(forKey: colorSchemeKey) }
        set(newValue) { defaults.set(newValue, forKey: colorSchemeKey)} }
    
    
    // MARK: - Keys
    
    private static let isVibrationOnKey = "isVibrationOn"
    
    private static let colorSchemeKey = "colorScheme"
    
    // MARK: - Setting default values
    // call in AppDelegate on start
    
    static func setDefault() {
        BaseSettings.setDefault()
        
        
        if defaults.value(forKey: isVibrationOnKey) == nil {
            defaults.set(true, forKey: isVibrationOnKey)
        }
        if defaults.value(forKey: colorSchemeKey) == nil {
            defaults.set(2, forKey: colorSchemeKey)
        }
    }
}
