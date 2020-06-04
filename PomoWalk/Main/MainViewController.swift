//
//  MainViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 09.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import CoreMotion

enum ActivityType {
    case work
    case walk
}

class MainViewController: UIViewController {
    
//    let pedometer = CMPedometer()
    
    let timerView = TimerView()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        timerView.center(in: view)
        timerView.setWidth(equalTo: view, multiplier: 0.7)
        
        
//        pedometer.startUpdates(from: Date()) { (data, error) in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.async {
//                self.label.text = String(Int(truncating: data.numberOfSteps))
//            }
//        }
    }
   
    
   
    
}
