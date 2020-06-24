//
//  m_Task.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 22.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

struct Task: Codable {
    var title: String
    var isActive: Bool
    var intervalsPlanned: Int?
    
    // Decoding and encoding
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("tasks").appendingPathExtension("plist")
    
    static func saveToFile(tasks: [Task]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedTasks = try? propertyListEncoder.encode(tasks)
        try? encodedTasks?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Task]? {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedTasksData = try? Data(contentsOf: archiveURL) else { return nil }
        return try? propertyListDecoder.decode(Array<Task>.self, from: retrievedTasksData)
    }
    
    func option() -> MenuOption {
        return MenuOption(title: title, isSelected: isActive)
    }
    
    func switchedOff() -> Task {
        var task = self
        task.isActive = false
        return task
    }
}

