//
//  MainViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 09.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import CoreMotion


class MainViewController: UIViewController {
    
    weak var coordinator: TimerCoordinator?
    
    //    let pedometer = CMPedometer()
    
    var activityType: ActivityType = .work {
        didSet {
            counter.type = activityType
            
            timerLabel.textColor = activityType == .work ? UIColor.workCounterColor : UIColor.walkCounterColor
            
            startStopButton.backgroundColor = activityType == .work ? UIColor.workCounterColor : UIColor.walkCounterColor
            
            
            walkWorkButton.backgroundColor = activityType == .work ? UIColor.walkCounterColor : UIColor.workCounterColor
            let walkOrWork = activityType == .work ? Strings.walk : Strings.work
            walkWorkButton.setTitle(walkOrWork, for: .normal)
        }
    }
    
    var isTimerRunning: Bool = false {
        didSet {
            if isTimerRunning {
                startStopButton.setTitle(Strings.stop, for: .normal)
            }
            else {
                startStopButton.setTitle(Strings.start, for: .normal)
            }
        }
    }
    
    // MARK: - UI Elements
    
    let timerView = UIView()
    
    let stackView = UIStackView()
    
    let timerLabel = UILabel()
    
    let counter = TimerCounterView()
    
    let startStopButton = RoundButton()
    
    let walkWorkButton = RoundButton()
    
    
    var timer: Timer?
    
    var fireDate: Date?
    var startInterval: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        timerView.center(in: view)
        timerView.setWidth(equalTo: view, multiplier: 0.7)
        setupLayout()
        initialSetup()
        
        //        pedometer.startUpdates(from: Date()) { (data, error) in
        //            guard let data = data, error == nil else { return }
        //            DispatchQueue.main.async {
        //                self.label.text = String(Int(truncating: data.numberOfSteps))
        //            }
        //        }
    }
    
    func setupLayout() {
        stackView.pinToEdges(to: timerView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.addArrangedSubview(timerLabel)
        stackView.addArrangedSubview(counter)
        stackView.addArrangedSubview(walkWorkButton)
        counter.setWidth(equalTo: timerView)
        counter.setEqualHeight()
        startStopButton.center(in: counter)
        startStopButton.setWidth(equalTo: counter, multiplier: 0.4)
        startStopButton.setEqualHeight()
        walkWorkButton.setWidth(equalTo: startStopButton)
        walkWorkButton.setEqualHeight()
    }
    
    func initialSetup() {
       
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.timerFont
        timerLabel.textColor = UIColor.workCounterColor
        
        counter.backgroundColor = .clear
        
        startStopButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        startStopButton.titleLabel?.font = UIFont.buttonsFont
        startStopButton.setTitle(Strings.start, for: .normal)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        
        walkWorkButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        walkWorkButton.titleLabel?.font = UIFont.buttonsFont
        walkWorkButton.addTarget(self, action: #selector(walkWorkButtonTapped), for: .touchUpInside)
    }
    
    @objc func updateCounter() {
        guard let fireDate = fireDate else { return }
        let remainingTimeInterval = (fireDate - Date()).rounded()
        counter.percentRemaining = CGFloat(remainingTimeInterval / startInterval)
        timerLabel.text = remainingTimeInterval.timerString
        if remainingTimeInterval <= 0 {
            timer?.invalidate()
            timer = nil
            startStopButton.setTitle(Strings.start, for: .normal)
        }
    }
    
    @objc func startStopButtonTapped() {
        startStopButton.animate(scale:1.1)
        if timer == nil {
            // Create and start timer
            coordinator?.startTimer()
            startStopButton.setTitle(Strings.stop, for: .normal)
            
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
            fireDate = Date().addingTimeInterval(startInterval)
            timer?.tolerance = 0.2
            timer?.fire()
        }
        else {
            // Stop timer and clean up
            coordinator?.stopTimer()
            startStopButton.setTitle(Strings.start, for: .normal)
            
            timer?.invalidate()
            timer = nil
            timerLabel.text = String(format: "%02i : %02i", Int(startInterval) / 60, 0)
            counter.percentRemaining = 1.0
            fireDate = nil
            Interval.saveToFile(intervals: [])
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    @objc func walkWorkButtonTapped() {
        walkWorkButton.animate(scale: 1.1)
        coordinator?.switchActivityType(currentType: activityType)
        
        if activityType == .work {
            activityType = .walk
        }
        else {
            activityType = .work
        }
        Interval.saveToFile(intervals: [])
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        fireDate = nil
        
    }
    
    func updateUI(timeString: String, percentRemaining: CGFloat) {
        timerLabel.text = timeString
        counter.percentRemaining = percentRemaining
    }
}
