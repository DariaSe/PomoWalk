//
//  SoundColorSettings.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class SoundColorSettings {
    
    static let defaults = UserDefaults.standard
    
    // MARK: - Values
    
    static var workEndSound: String {
        get { defaults.string(forKey: workEndSoundKey) ?? "jazzy" }
        set(newValue) { defaults.set(newValue, forKey: workEndSoundKey)} }
    
    static var walkEndSound: String {
        get { defaults.string(forKey: walkEndSoundKey) ?? "cymbal" }
        set(newValue) { defaults.set(newValue, forKey: walkEndSoundKey)} }
    
    static var isVibrationOn: Bool {
        get { defaults.bool(forKey: isVibrationOnKey)}
        set(newValue) { defaults.set(newValue, forKey: isVibrationOnKey)} }
    
    
    static var colorScheme: Int {
        get { defaults.integer(forKey: colorSchemeKey) }
        set(newValue) { defaults.set(newValue, forKey: colorSchemeKey)} }
    
    
    // MARK: - Keys
    
    static let workEndSoundKey = "workEndSound"
    static let walkEndSoundKey = "walkEndSound"
    private static let isVibrationOnKey = "isVibrationOn"
    
    static let colorSchemeKey = "colorScheme"
    
    // MARK: - Setting default values
    // call in AppDelegate on start
    
    static func setDefault() {
        
        if defaults.value(forKey: workEndSoundKey) == nil {
            defaults.set("jazzy", forKey: workEndSoundKey)
        }
        if defaults.value(forKey: walkEndSoundKey) == nil {
            defaults.set("cymbal", forKey: walkEndSoundKey)
        }
        if defaults.value(forKey: isVibrationOnKey) == nil {
            defaults.set(true, forKey: isVibrationOnKey)
        }
        
        if defaults.value(forKey: colorSchemeKey) == nil {
            defaults.set(0, forKey: colorSchemeKey)
        }
    }
    
    static var colorSchemes: [MenuOption] {
        var schemes = [MenuOption(title: "Nature", isSelected: false), MenuOption(title: "Blueberry", isSelected: false), MenuOption(title: "Lemonade", isSelected: false), MenuOption(title: "Frozen", isSelected: false)]
        for (index, _) in schemes.enumerated() {
            schemes[index].isSelected = index == colorScheme
        }
        return schemes
    }
    
    static var workEndSounds: [MenuOption] {
        Sound.allCases.map { MenuOption(title: $0.rawValue.capitalized, isSelected: $0.rawValue == workEndSound)}
    }
    
    static var walkEndSounds: [MenuOption] {
        Sound.allCases.map { MenuOption(title: $0.rawValue.capitalized, isSelected: $0.rawValue == walkEndSound)}
    }
}

enum Sound: String, CaseIterable {
    case jazzy
    case cymbal
    case notification
    case opening
    case spaceship
}
