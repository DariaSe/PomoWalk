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
            switch activityType {
            case .work:
                timerLabel.textColor = UIColor.workCounterColor
                startStopButton.backgroundColor = UIColor.workCounterColor
                walkWorkButton.backgroundColor = UIColor.walkCounterColor
                walkWorkButton.setTitle(Strings.walk, for: .normal)
            case .walk, .longPause:
                timerLabel.textColor = UIColor.walkCounterColor
                startStopButton.backgroundColor = UIColor.walkCounterColor
                walkWorkButton.backgroundColor = UIColor.workCounterColor
                walkWorkButton.setTitle(Strings.work, for: .normal)
            }
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
        
        counter.backgroundColor = .clear
        
        startStopButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        startStopButton.titleLabel?.font = UIFont.buttonsFont
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        
        walkWorkButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        walkWorkButton.titleLabel?.font = UIFont.buttonsFont
        walkWorkButton.addTarget(self, action: #selector(walkWorkButtonTapped), for: .touchUpInside)
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
