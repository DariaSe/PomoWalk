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
    
    var activityType: ActivityType = .work {
        didSet {
            counter.type = activityType
            switch activityType {
            case .work:
                timerLabel.textColor = UIColor.workCounterColor
                startStopButton.backgroundColor = UIColor.workCounterColor
                walkWorkButton.backgroundColor = UIColor.walkCounterColor
                walkWorkButton.setTitle(Strings.walk, for: .normal)
                currentStepsLabel.isHidden = true
                taskButton.isHidden = false
            case .walk, .longPause:
                timerLabel.textColor = UIColor.walkCounterColor
                startStopButton.backgroundColor = UIColor.walkCounterColor
                walkWorkButton.backgroundColor = UIColor.workCounterColor
                walkWorkButton.setTitle(Strings.work, for: .normal)
                currentStepsLabel.textColor = UIColor.walkCounterColor
                currentStepsLabel.isHidden = false
                taskButton.isHidden = true
            }
        }
    }
    
    var task: String? {
        didSet {
            taskButton.setTitle(task, for: .normal)
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
   
    let currentStepsLabel = UILabel()
    
    let taskButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        timerView.center(in: view)
        timerView.setWidth(equalTo: view, multiplier: 0.7)
        setupLayout()
        initialSetup()
        
        UserDefaults.standard.addObserver(self, forKeyPath: SoundColorSettings.colorSchemeKey, options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.getTasks()
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
        
        view.addSubview(currentStepsLabel)
        currentStepsLabel.translatesAutoresizingMaskIntoConstraints = false
        currentStepsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentStepsLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -10).isActive = true
        
        taskButton.constrainToLayoutMargins(of: view, leading: 0, trailing: 0, top: nil, bottom: nil)
        taskButton.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -10).isActive = true
    }
    
    func initialSetup() {
        
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.timerFont
        
        counter.backgroundColor = .clear
        
        startStopButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        startStopButton.titleLabel?.font = UIFont.buttonsFont
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        
        walkWorkButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        walkWorkButton.titleLabel?.font = UIFont.buttonsFont
        walkWorkButton.addTarget(self, action: #selector(walkWorkButtonTapped), for: .touchUpInside)
        
        currentStepsLabel.font = UIFont.stepperUnitFont
        currentStepsLabel.text = Strings.steps + "0"
        
        taskButton.setTitleColor(UIColor.textColor, for: .normal)
        taskButton.titleLabel?.font = UIFont.stepperUnitFont
        taskButton.titleLabel?.adjustsFontSizeToFitWidth = true
        taskButton.addTarget(self, action: #selector(taskButtonPressed), for: .touchUpInside)
    }
    
    @objc func taskButtonPressed() {
        coordinator?.showTasks()
    }
    
    func setupStepsLabels(current: Int) {
        currentStepsLabel.text = String(current)
    }
    
    
    @objc func startStopButtonTapped() {
        startStopButton.animate(scale:1.1)
        coordinator?.startOrStopTimer()
    }
    
    @objc func walkWorkButtonTapped() {
        walkWorkButton.animate(scale: 1.1)
        coordinator?.alertSwitchActivityType(currentType: activityType)
    }
    
    func updateUI(timeString: String, percentRemaining: CGFloat) {
        timerLabel.text = timeString
        counter.percentRemaining = percentRemaining
    }
}

// UserDefaults Observer
extension MainViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == SoundColorSettings.colorSchemeKey {
            view.backgroundColor = UIColor.backgroundColor
            let sameType = activityType
            activityType = sameType
            taskButton.setTitleColor(UIColor.textColor, for: .normal)
        }
    }
}
