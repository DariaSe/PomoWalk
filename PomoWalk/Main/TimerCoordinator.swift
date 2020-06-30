//
//  TimerCoordinator.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 06.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import CoreMotion

class TimerCoordinator: NSObject {
    
    let timerVC = MainViewController()
    let timerManager = TimerManager()
    let notificationsManager = NotificationsManager()
    
    lazy var tasksVC: TasksViewController = {
        let taskVC = TasksViewController()
        taskVC.delegate = self
        taskVC.modalPresentationStyle = .overCurrentContext
        return taskVC
    }()
    
    let pedometer = CMPedometer()
    
    var fireDate: Date?
    var startTimeInterval: TimeInterval = 0 {
        didSet {
            let timerString = startTimeInterval.timerString
            timerVC.updateUI(timeString: timerString, percentRemaining: 1.0)
        }
    }
    
    var activityType: ActivityType = .work {
        didSet {
            timerVC.activityType = activityType
        }
    }
    
    var tasks: [Task] = [] {
        didSet {
            tasksVC.options = tasks.map { $0.option() }
            Task.saveToFile(tasks: tasks)
            if let activeTask = tasks.filter({ $0.isActive }).first {
                timerVC.taskButton.setTitle(activeTask.title, for: .normal)
            }
            else {
                timerVC.taskButton.setTitle(Strings.newTask, for: .normal)
            }
        }
    }
    
    func start() {
        timerVC.coordinator = self
        timerManager.delegate = self
        if let intervals = Interval.loadAllFromFile(), !intervals.isEmpty {
            if let currentInterval = intervals
                .filter({($0.startDate < (Date() + 1))&&($0.endDate > Date())}).first {
                fireDate = currentInterval.endDate
                startTimeInterval = currentInterval.duration
                activityType = ActivityType(rawValue: currentInterval.activityType)!
                if CMPedometer.isStepCountingAvailable() {
                    currentInterval.getSteps(from: pedometer) { [unowned self] (stepsNumber) in
                        self.showCurrentSteps(startingWith: stepsNumber ?? 0)
                    }
                }
                timerManager.startTimer()
                timerVC.isTimerRunning = true
            }
            else {
                stopTimer()
                setDefaultUI()
            }
        }
        else {
            setDefaultUI()
        }
        getTasks()
      
        UserDefaults.standard.addObserver(self, forKeyPath: BaseSettings.workIntervalDurationKey, options: .new, context: nil)
        UserDefaults.standard.addObserver(self, forKeyPath: BaseSettings.walkIntervalDurationKey, options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        stopTimer()
        setDefaultUI()
    }
    
    func getTasks() {
        if let tasks = Task.loadFromFile() {
            self.tasks = tasks
        }
        else {
            self.timerVC.taskButton.setTitle(Strings.newTask, for: .normal)
        }
    }
    
    func setDefaultUI() {
        activityType = .work
        let workDuration = BaseSettings.workIntervalDuration
        startTimeInterval = TimeInterval(workDuration * 60)
        timerVC.isTimerRunning = false
    }
    
    func startOrStopTimer() {
        if timerManager.timer == nil {
            startTimer()
        }
        else {
            alertStop()
        }
    }
    
    func startTimer() {
        fireDate = Date() + startTimeInterval
        timerManager.startTimer()
        timerVC.isTimerRunning = true
        notificationsManager.scheduleNotifications(startingWith: activityType)
        setTaskForIntervals()
        showCurrentSteps()
    }
    
    func setTaskForIntervals() {
        if let activeTask = tasks.filter({  $0.isActive }).first, var intervals = Interval.loadAllFromFile(), !intervals.isEmpty {
            intervals = intervals.map { ($0.activityType == "work") && ($0.endDate > Date()) ? $0.withTask(activeTask.title) : $0 }
            Interval.saveAllToFile(intervals: intervals)
        }
    }
    
    func alertStop() {
        let alert = UIAlertController(title: Strings.stopQuestion, message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: Strings.yes, style: .destructive) { [unowned self] (_) in
            self.stopTimer()
        }
        let no = UIAlertAction(title: Strings.no, style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        timerVC.present(alert, animated: true)
    }
    
    func stopTimer() {
        if let intervals = Interval.loadAllFromFile(), !intervals.isEmpty {
            Interval.filterAndSaveFinished(from: intervals)
        }
        timerManager.stopTimer()
        fireDate = nil
        timerVC.isTimerRunning = false
        let timerString = startTimeInterval.timerString
        timerVC.updateUI(timeString: timerString, percentRemaining: 1.0)
        Interval.saveAllToFile(intervals: [])
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        pedometer.stopUpdates()
    }
    
    func alertSwitchActivityType(currentType: ActivityType) {
        if timerManager.timer != nil {
            var walkOrWork: String
            switch activityType {
            case .work: walkOrWork = Strings.switchToWalk
            default: walkOrWork = Strings.switchToWork
            }
            let alert = UIAlertController(title: Strings.switchActivityQuestion + walkOrWork, message: nil, preferredStyle: .alert)
            let yes = UIAlertAction(title: Strings.yes, style: .destructive) { [unowned self] (_) in
                self.stopTimer()
                self.switchActivityType()
            }
            let no = UIAlertAction(title: Strings.no, style: .cancel, handler: nil)
            alert.addAction(yes)
            alert.addAction(no)
            timerVC.present(alert, animated: true)
        }
        else {
            switchActivityType()
        }
    }
    
    func switchActivityType() {
        if activityType == .work {
            activityType = .walk
            let walkDuration = BaseSettings.walkIntervalDuration
            startTimeInterval = TimeInterval(walkDuration * 60)
            self.timerVC.currentStepsLabel.text = Strings.steps + "0"
        }
        else {
            activityType = .work
            let workDuration = BaseSettings.workIntervalDuration
            startTimeInterval = TimeInterval(workDuration * 60)
        }
        Interval.saveAllToFile(intervals: [])
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func startNext() {
        pedometer.stopUpdates()
        timerVC.currentStepsLabel.text = Strings.steps + "0"
        if let interval = Interval.current() {
            fireDate = interval.endDate
            startTimeInterval = interval.duration
            activityType = ActivityType(rawValue: interval.activityType)!
            timerManager.startTimer()
            showCurrentSteps()
        }
        else {
            stopTimer()
            setDefaultUI()
        }
    }
    
    func showCurrentSteps(startingWith stepsNumber: Int = 0) {
        if activityType != .work, CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [unowned self] (data, error) in
                guard let data = data, error == nil else { return }
                let countedStepsNumber = Int(truncating: data.numberOfSteps)
                let totalNumber = stepsNumber + countedStepsNumber
                DispatchQueue.main.async {
                    self.timerVC.currentStepsLabel.text = Strings.steps + String(totalNumber)
                }
            }
        }
    }
    
    
    func showTasks() {
        timerVC.present(tasksVC, animated: true)
    }
}

extension TimerCoordinator: TimerDelegate {
    func updateUI() {
        guard let fireDate = fireDate else { return }
        let remainingTimeInterval = (fireDate - Date()).rounded()
        let timerString = remainingTimeInterval.timerString
        let percent = CGFloat(remainingTimeInterval / startTimeInterval)
        timerVC.updateUI(timeString: timerString, percentRemaining: percent)
        if remainingTimeInterval <= 0 {
            timerManager.stopTimer()
            if BaseSettings.isAutoContinued {
                startNext()
            }
            else {
                stopTimer()
            }
        }
    }
}

extension TimerCoordinator: MenuDelegate {
    
    func addButtonPressed() {
        tasks.append(Task(title: "", isActive: false, intervalsPlanned: nil))
        tasksVC.menuView.editingRow = tasks.count - 1
        tasksVC.menuView.tableView.scrollToRow(at: IndexPath(row: tasks.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    func didSelectOption(index: Int) {
        tasks = self.tasks.map { $0.switchedOff() }
        tasks[index].isActive = true
        setTaskForIntervals()
    }
    
    func optionChanged(text: String, index: Int) {
        tasks[index].title = text
        tasksVC.menuView.editingRow = nil
        if tasks[index].title == "" && index == tasks.count - 1 {
            tasks.removeLast()
        }
    }
    
    func deleteOption(index: Int) {
        tasks.remove(at: index)
    }
}
