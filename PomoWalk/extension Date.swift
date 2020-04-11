//
//  extension Date.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 11.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

extension TimeInterval {
    var timerString: String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format:"%02i : %02i", minutes, seconds)
    }
}
