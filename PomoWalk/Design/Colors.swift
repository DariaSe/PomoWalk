//
//  Colors.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 10.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIColor {
    
    static let colorScheme: ColorScheme = ColorScheme(rawValue: Settings.colorScheme) ?? ColorScheme.bright
    
    static var backgroundColor: UIColor {
        switch colorScheme {
        case .bright:
            return UIColor(netHex: 0xF2E97B)
        case .dark:
            return UIColor(netHex: 0x38362E)
        case .purple:
            return UIColor(netHex: 0x372948)
        }
    }
    
    static var textColor: UIColor {
        switch colorScheme {
        case .bright:
            return UIColor(netHex: 0xD37348)
        case .dark:
            return UIColor(netHex: 0xB2572F)
        case .purple:
            return UIColor(netHex: 0x8D457C)
        }
    }
    
    static var workCounterColor: UIColor {
        switch colorScheme {
        case .bright:
            return UIColor(netHex: 0xD37348)
        case .dark:
            return UIColor(netHex: 0xB2572F)
        case .purple:
            return UIColor(netHex: 0x8D457C)
        }
    }
    
    static var walkCounterColor: UIColor {
        switch colorScheme {
        case .bright:
            return UIColor(netHex: 0x83B441)
        case .dark:
            return UIColor(netHex: 0x5B7432)
        case .purple:
            return UIColor(netHex: 0x497774)
        }
    }
}

enum ColorScheme: Int {
    case bright
    case dark
    case purple
}
