//
//  TimerManager.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 06.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

class TimerManager {
    
    var timer: Timer?
    
    var delegate: TimerDelegate?
    
    func startTimer() {
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        timer?.tolerance = 0.2
        timer?.fire()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerFired() {
        delegate?.updateUI()
    }
}

protocol TimerDelegate {
    func updateUI()
}
