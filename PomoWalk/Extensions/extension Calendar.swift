//
//  extension Calendar.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 16.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

extension Calendar {
    
    var localWeekdaySymbols: [String] {
        var symbols: [String] = []
        
        let dateFormatter = DateFormatter()
        let language = Locale.preferredLanguages.first
        dateFormatter.dateFormat = "EE" // two letters for weekday
        if let language = language {
            dateFormatter.locale = Locale(identifier: language)
        }
        
        let today = Date()
        let weekStart = Calendar.current.dateInterval(of: .weekOfYear, for: today)!.start
        let weekEnd = Calendar.current.dateInterval(of: .weekOfYear, for: today)!.end.addingTimeInterval(-86400)
        let range = Calendar.current.range(from: weekStart, to: weekEnd)
        for date in range {
            let daySymbol = dateFormatter.string(from: date).uppercased()
            symbols.append(daySymbol)
        }
        return symbols
    }
    
    func range(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should return an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
}
