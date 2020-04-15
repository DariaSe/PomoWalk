//
//  TimerView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 10.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    var activityType: ActivityType = .work {
        didSet {
            counter.type = activityType
            counter.percentRemaining = 1.0
            label.textColor = activityType == .work ? UIColor.workCounterColor : UIColor.walkCounterColor
            startButton.backgroundColor = activityType == .work ? UIColor.workCounterColor : UIColor.walkCounterColor
            startButton.setTitle("START", for: .normal)
            timer?.invalidate()
            timer = nil
            walkWorkButton.backgroundColor = activityType == .work ? UIColor.walkCounterColor : UIColor.workCounterColor
            let walkOrWork = activityType == .work ? "WALK" : "WORK"
            walkWorkButton.setTitle(walkOrWork, for: .normal)
            let intervalDuration = activityType == .work ? BaseSettings.workIntervalDuration : BaseSettings.walkIntervalDuration
            startInterval = TimeInterval(intervalDuration * 60)
            startInterval = 5
            label.text = String(format: "%02i : %02i", intervalDuration, 0)
        }
    }
    // MARK: - UI Elements
    
    let stackView = UIStackView()
    
    let label = UILabel()
    
    let counter = TimerCounterView()
    
    let startButton = RoundButton()
       
    let walkWorkButton = RoundButton()
       
    
    var timer: Timer?
    
    var fireDate: Date?
    var startInterval: TimeInterval = 0
    
    var counterType: ActivityType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        stackView.pinToEdges(to: self)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(counter)
        stackView.addArrangedSubview(walkWorkButton)
        counter.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        counter.heightAnchor.constraint(equalTo: counter.widthAnchor).isActive = true
        startButton.center(in: counter)
        startButton.widthAnchor.constraint(equalTo: counter.widthAnchor, multiplier: 0.4).isActive = true
        startButton
            .heightAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        walkWorkButton.widthAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        walkWorkButton.heightAnchor.constraint(equalTo: walkWorkButton.widthAnchor).isActive = true
    }
    
    func initialSetup() {
        startInterval = TimeInterval(BaseSettings.workIntervalDuration * 60)
        
        label.text = String(format: "%02i : %02i", BaseSettings.workIntervalDuration, 0)
        label.textAlignment = .center
        label.font = UIFont.timerFont
        label.textColor = UIColor.workCounterColor
        
        counter.backgroundColor = .clear
        
        startButton.backgroundColor = UIColor.workCounterColor
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        startButton.titleLabel?.font = UIFont.buttonsFont
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        walkWorkButton.backgroundColor = UIColor.walkCounterColor
        walkWorkButton.setTitle("WALK", for: .normal)
        walkWorkButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        walkWorkButton.titleLabel?.font = UIFont.buttonsFont
        walkWorkButton.addTarget(self, action: #selector(walkWorkButtonTapped), for: .touchUpInside)
    }
    
    @objc func updateCounter() {
        guard let fireDate = fireDate else { return }
        let remainingTimeInterval = fireDate - Date()
        counter.percentRemaining = CGFloat(remainingTimeInterval / startInterval)
        if remainingTimeInterval > 0 {
            label.text = remainingTimeInterval.timerString
        }
        else {
            timer?.invalidate()
            timer = nil
            startButton.setTitle("START", for: .normal)
        }
    }
    
    @objc func startButtonTapped() {
        if timer == nil {
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
            fireDate = Date().addingTimeInterval(startInterval)
            timer?.tolerance = 0.2
            timer?.fire()
            startButton.setTitle("STOP", for: .normal)
            let text = activityType == .work ? "It's time to walk" : "It's time to go back to work!"
            scheduleNotification(text: text)
        }
        else {
            timer?.invalidate()
            timer = nil
            startButton.setTitle("START", for: .normal)
            label.text = String(format: "%02i : %02i", Int(startInterval) / 60, 0)
            counter.percentRemaining = 1.0
            fireDate = nil
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        startButton.animate(scale:1.1)
    }
    
    @objc func walkWorkButtonTapped() {
        if activityType == .work {
            activityType = .walk
        }
        else {
            activityType = .work
        }
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        fireDate = nil
        walkWorkButton.animate(scale: 1.1)
    }
    
    func scheduleNotification(text: String) {
        let content = UNMutableNotificationContent()
        content.title = "Time's up!"
        content.body = text
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: startInterval, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
    }
    
    func startTimer(for activity: ActivityType) {
        
    }
}
