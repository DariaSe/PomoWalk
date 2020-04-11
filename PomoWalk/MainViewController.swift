//
//  MainViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 09.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import CoreMotion

enum CounterType {
    case work
    case walk
}

class MainViewController: UIViewController {
    
//    let pedometer = CMPedometer()
    
    let label = UILabel()
    
    let counter = TimerCounterView()
    
    var fireDate: Date?
    var startInterval: TimeInterval?
    
    var counterType: CounterType?
    
    var timer: Timer?
    
    let startButton = UIButton()
    let settingsButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        counter.center(in: view)
        let width = UIScreen.main.bounds.width - 80
        counter.widthAnchor.constraint(equalToConstant: width).isActive = true
        counter.heightAnchor.constraint(equalTo: counter.widthAnchor).isActive = true
        counter.backgroundColor = .clear
        label.constrainToEdges(of: counter, leading: 0, trailing: 0, top: -50, bottom: nil)
        label.text = "26 : 48"
        label.textAlignment = .center
        label.font = UIFont.timerFont
        label.textColor = UIColor.textColor
        startButton.center(in: counter)
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(UIColor.textColor, for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        settingsButton.constrainToEdges(of: view, leading: 20, trailing: 20, top: 20, bottom: nil)
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.setTitleColor(UIColor.textColor, for: .normal)
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
        
//        pedometer.startUpdates(from: Date()) { (data, error) in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.async {
//                self.label.text = String(Int(truncating: data.numberOfSteps))
//            }
//        }
    }
   
    
   
    @objc func updateTimer() {
        guard let fireDate = fireDate, let startInterval = startInterval else { return }
        let remainingTimeInterval = fireDate - Date()
        counter.percentRemaining = CGFloat(remainingTimeInterval / startInterval)
        if remainingTimeInterval > 0 {
            label.text = remainingTimeInterval.timerString
        }
        else {
            print("Send notification")
            timer?.invalidate()
            timer = nil
            startButton.setTitle("START", for: .normal)
        }
    }
    
    @objc func startButtonTapped() {
        if timer == nil {
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
            fireDate = Date().addingTimeInterval(180)
            startInterval = fireDate! - Date()
            timer?.tolerance = 0.2
            timer?.fire()
            startButton.setTitle("STOP", for: .normal)
        }
        else {
            timer?.invalidate()
            timer = nil
            startButton.setTitle("START", for: .normal)
        }
    }
    
    @objc func showSettings() {
        
    }
}
