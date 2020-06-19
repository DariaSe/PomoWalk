//
//  BadgesCoordinator.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 18.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import CoreMotion

class BadgesCoordinator {
    
    let badgesVC = BadgesViewController()
    let pedometer = CMPedometer()
    
    func start() {
        badgesVC.coordinator = self
        guard CMPedometer.isStepCountingAvailable() else {
            badgesVC.collectionView.isHidden = true
            badgesVC.stepsUnavailableLabel.isHidden = false
            return
        }
        badgesVC.stepsUnavailableLabel.isHidden = true
        var currentFinished = [Interval]()
        var savedFinished = [Interval]()
        if let currentIntervals = Interval.loadAllFromFile() {
            currentFinished = currentIntervals.filter { $0.endDate < Date() }
        }
        if let savedIntervals = Interval.loadFinishedFromFile() {
            savedFinished = savedIntervals
        }
        let intervals = savedFinished + currentFinished
        guard !intervals.isEmpty else {
            self.badgesVC.badges = [Badge.stepsBadges(), Badge.walksBadges()]
            self.badgesVC.headers = [Strings.totalSteps + "0", Strings.totalWalks + "0"]
            return
        }
        Interval.getStepsForFinishedIntervals(intervals: intervals, from: pedometer) { [unowned self] (intervals) in
            let totalSteps = intervals.compactMap { $0.steps }.reduce(0) {$0 + $1}
            let stepsBadges = Badge.stepsBadges().map { $0.withCurrentNumber(totalSteps) }
            let totalWalks = intervals.filter {($0.steps ?? 0) > 50}.count
            let walksBadges = Badge.walksBadges().map {$0.withCurrentNumber(totalWalks)}
            DispatchQueue.main.async {
                self.badgesVC.badges = [stepsBadges, walksBadges]
                self.badgesVC.headers = [Strings.totalSteps + totalSteps.string, Strings.totalWalks + totalWalks.string]
            }
        }
    }
}
