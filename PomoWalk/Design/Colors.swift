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
    
    static var colorScheme: ColorScheme { ColorScheme(rawValue: SoundColorSettings.colorScheme) ?? ColorScheme.lemonade
    }
    
    static var backgroundColor: UIColor {
        switch colorScheme {
        case .lemonade:
            return UIColor(netHex: 0xFFF89B)
        case .nature:
            return UIColor(netHex: 0x38362E)
        case .blueberry:
            return UIColor(netHex: 0x372948)
        case .frozen:
            return UIColor(netHex: 0xB5E2FA)
        }
    }
    
    static var textColor: UIColor {
        switch colorScheme {
        case .lemonade:
            return UIColor(netHex: 0xD37348)
        case .nature:
            return UIColor(netHex: 0xB2572F)
        case .blueberry:
            return UIColor(netHex: 0x8D457C)
            case .frozen:
            return UIColor(netHex: 0x9875A5)
        }
    }
    
    static var workCounterColor: UIColor {
        switch colorScheme {
        case .lemonade:
            return UIColor(netHex: 0xD37348)
        case .nature:
            return UIColor(netHex: 0xB2572F)
        case .blueberry:
            return UIColor(netHex: 0x8D457C)
            case .frozen:
            return UIColor(netHex: 0x9875A5)
        }
    }
    
    static var walkCounterColor: UIColor {
        switch colorScheme {
        case .lemonade:
            return UIColor(netHex: 0x83B441)
        case .nature:
            return UIColor(netHex: 0x5B7432)
        case .blueberry:
            return UIColor(netHex: 0x497774)
            case .frozen:
            return UIColor(netHex: 0x4191B4)
        }
    }
    
    static var backgroundCompanionColor: UIColor {
        switch colorScheme {
        case .lemonade:
            return UIColor(netHex: 0xB0CC6E)
        case .nature:
            return UIColor(netHex: 0x4C5B30)
        case .blueberry:
            return UIColor(netHex: 0x6A3967)
            case .frozen:
            return UIColor(netHex: 0x6FAFD0)
        }
    }
}

enum ColorScheme: Int {
    case nature
    case blueberry
    case lemonade
    case frozen
}
