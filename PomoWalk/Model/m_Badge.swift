//
//  m_Badge.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 19.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct Badge {
    var title: String
    var currentNumber: Int
    var maxNumber: Int
    var isCompleted: Bool
    
    func withCurrentNumber(_ number: Int) -> Badge {
        var badge = self
        badge.currentNumber = number
        badge.isCompleted = number >= maxNumber
        return badge
    }
    
    static func stepsBadges() -> [Badge] {
        let numbers = [1000, 3000, 5000, 10000, 20000, 30000, 50000, 100000, 500000, 1000000]
        let strings = ["1k", "3k", "5k", "10k", "20k", "30k", "50k", "100k", "500k", "1M"]
        let zipped = Array(zip(numbers, strings))
        return zipped.map { Badge(title: $0.1, currentNumber: 0, maxNumber: $0.0, isCompleted: false) }
    }
    
    static func walksBadges() -> [Badge] {
        let numbers = [5, 10, 15, 25, 50, 100, 150, 300, 500, 1000]
        return numbers.map { Badge(title: $0.string, currentNumber: 0, maxNumber: $0, isCompleted: false) }
    }
    
    static func daysBadges() -> [Badge] {
        let numbers = [1, 3, 5, 10, 20, 30, 50, 70, 100]
        return numbers.map { Badge(title: $0.string, currentNumber: 0, maxNumber: $0, isCompleted: false) }
    }
}

