//
//  HistoryCoordinator.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 21.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import CoreMotion

class HistoryCoordinator {
    
    let historyVC = HistoryViewController()
    
    lazy var tasksVC: TasksViewController = {
        let taskVC = TasksViewController()
        taskVC.delegate = self
        taskVC.addButton.isHidden = true
        taskVC.isEditable = false
        taskVC.modalPresentationStyle = .overCurrentContext
        return taskVC
    }()
    
    var tasks: [Task] = [] {
        didSet {
            tasksVC.options = tasks.map({$0.option()})
        }
    }
    
    var newTask: ((String) -> Void)?
    
    var intervals: [Interval] = [] {
        didSet {
            guard !intervals.isEmpty else { self.historyVC.intervals = [[Interval]](); return }
            let divided = self.dividedIntervals(intervals)
            DispatchQueue.main.async {
                self.historyVC.intervals = divided
            }
        }
    }
    
    func start() {
        historyVC.coordinator = self
    }
    
    func getInfo() {
        var savedFinished = [Interval]()
        var currentFinished = [Interval]()
        if let savedIntervals = Interval.loadFinishedFromFile() {
            savedFinished = savedIntervals
        }
        if let currentIntervals = Interval.loadAllFromFile() {
            currentFinished = currentIntervals.filter { $0.endDate < Date() }
        }
        Interval.getStepsForIntervals(intervals: currentFinished, from: Interval.pedometer) { [unowned self] (intervalsWithSteps) in
            let intervals = (savedFinished + intervalsWithSteps).sorted(by: >)
            self.intervals = intervals
        }
    }
    
    func dividedIntervals(_ intervals: [Interval]) -> [[Interval]] {
        var dividedIntervals = [[Interval]]()
        var date = intervals.first!.endDate.dayStart()
        let leastDate = intervals.last!.endDate - 86400
        while date >= leastDate {
            let intervalsOnDate = intervals.filter {$0.endDate.dayStart() == date}
            if !intervalsOnDate.isEmpty {
                dividedIntervals.append(intervalsOnDate)
            }
            date -= 86400
        }
        return dividedIntervals
    }
    
    func getTasks() {
        if let tasks = Task.loadFromFile() {
            self.tasks = tasks.map({$0.switchedOff()})
        }
    }
    
    
    func showTasks(for interval: Interval) {
        self.tasks = tasks.map({$0.switchedOff()})
        for (index, task) in tasks.enumerated() {
            if task.title == interval.task {
                tasks[index].isActive = true
            }
        }
        historyVC.present(tasksVC, animated: true)
        newTask = { [unowned self] task in
            self.changeTask(in: interval, newTask: task)
        }
    }
    
    func changeTask(in interval: Interval, newTask: String) {
        self.intervals = intervals.map({$0 == interval ? $0.withTask(newTask) : $0})
        if var finishedIntervals = Interval.loadFinishedFromFile() {
            if finishedIntervals.contains(interval) {
                finishedIntervals = finishedIntervals.map({$0 == interval ? $0.withTask(newTask) : $0})
                Interval.saveFinishedToFile(intervals: finishedIntervals)
            }
        }
        if var currentIntervals = Interval.loadAllFromFile() {
            if currentIntervals.contains(interval) {
                currentIntervals = currentIntervals.map({$0 == interval ? $0.withTask(newTask) : $0})
                Interval.saveAllToFile(intervals: currentIntervals)
            }
        }
    }
    
    func askDeletion(_ interval: Interval) {
        let alert = UIAlertController(title: Strings.deleteConfirm, message: "", preferredStyle: .alert)
        let yes = UIAlertAction(title: Strings.yes, style: .destructive) { [unowned self] (_) in
            self.deleteInterval(interval)
        }
        let no = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        historyVC.present(alert, animated: true)
    }
    
    func deleteInterval(_ interval: Interval) {
        self.intervals = intervals.filter { $0 != interval }
        if var finishedIntervals = Interval.loadFinishedFromFile() {
            if finishedIntervals.contains(interval) {
                finishedIntervals = finishedIntervals.filter { $0 != interval }
                Interval.saveFinishedToFile(intervals: finishedIntervals)
            }
        }
        if var currentIntervals = Interval.loadAllFromFile() {
            if currentIntervals.contains(interval) {
                currentIntervals = currentIntervals.filter { $0 != interval }
                Interval.saveAllToFile(intervals: currentIntervals)
            }
        }
    }
}

extension HistoryCoordinator: MenuDelegate {
    
    func addButtonPressed() {}
    
    func didSelectOption(index: Int) {
        tasks = self.tasks.map { $0.switchedOff() }
        tasks[index].isActive = true
        newTask?(tasks[index].title)
    }
    
    func optionChanged(text: String, index: Int) {}
    
    func deleteOption(index: Int) {}
}
