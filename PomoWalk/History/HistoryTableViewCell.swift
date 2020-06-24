//
//  HistoryTableViewCell.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 21.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    let separatorLine = UIView()
    let circle = UIView()
    let upperLine = UIView()
    let lowerLine = UIView()
    let horizontalLine = UIView()
    let label = UILabel()
    let timeLabel = UILabel()
    
    static let reuseIdentifier = "HistoryCell"
    
    var activityType: ActivityType = .work
    
    var circleWidth: CGFloat {
        switch activityType {
        case .work:
            return 20
        case .walk:
            return 10
        case .longPause:
            return 18
        }
    }
    
    var color: UIColor {
        switch activityType {
        case .work:
            return UIColor.workCounterColor
        case .walk:
            return UIColor.walkCounterColor
        case .longPause:
            return UIColor.walkCounterColor
        }
    }
    
    var linesColor: UIColor { UIColor.backgroundCompanionColor }
    
    var circleWidthConstraint = NSLayoutConstraint()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        separatorLine.constrainToEdges(of: contentView, leading: 55, trailing: 0, top: 0, bottom: nil)
        separatorLine.setHeight(equalTo: 0.5)
        separatorLine.backgroundColor = linesColor
        horizontalLine.centerVertically(in: contentView, leading: 20, trailing: nil)
        horizontalLine.setWidth(equalTo: 30)
        horizontalLine.setHeight(equalTo: 1)
        horizontalLine.backgroundColor = linesColor
        upperLine.constrainToEdges(of: contentView, leading: 20, trailing: nil, top: 0, bottom: 25)
        upperLine.setWidth(equalTo: 1)
        upperLine.backgroundColor = linesColor
        lowerLine.constrainToEdges(of: contentView, leading: 20, trailing: nil, top: 25, bottom: 0)
        lowerLine.setWidth(equalTo: 1)
        lowerLine.backgroundColor = linesColor
        circle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(circle)
        circle.centerVertically(in: self, leading: nil, trailing: nil)
        circle.centerXAnchor.constraint(equalTo: upperLine.centerXAnchor).isActive = true
        circleWidthConstraint = circle.widthAnchor.constraint(equalToConstant: 20)
        circleWidthConstraint.isActive = true
        circle.setEqualHeight()
        label.centerVertically(in: contentView, leading: 55, trailing: 20)
        label.font = UIFont(name: montserratSemiBold, size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byTruncatingMiddle
        timeLabel.constrainToEdges(of: contentView, leading: nil, trailing: 10, top: 5, bottom: nil)
        timeLabel.textColor = UIColor.backgroundCompanionColor
        timeLabel.font = UIFont.historyTimeFont
    }
    
    func update(with interval: Interval) {
        backgroundColor = UIColor.backgroundColor
        separatorLine.backgroundColor = linesColor
        horizontalLine.backgroundColor = linesColor
        upperLine.backgroundColor = linesColor
        lowerLine.backgroundColor = linesColor
        activityType = ActivityType(rawValue: interval.activityType)!
        circle.backgroundColor = color
        circleWidthConstraint.constant = circleWidth
        circle.layer.cornerRadius = circleWidth / 2
        label.textColor = color
        let duration = Int((interval.endDate - interval.startDate) / 60).string + " " + Strings.minutes
        if interval.activityType == "work" {
            if let task = interval.task {
                label.text = task + ": " + duration
            }
            else {
                label.text = Strings.work.lowercased().capitalized + ": " + duration
            }
        }
        else {
            if let steps = interval.steps {
                label.text = Strings.steps + steps.string
            }
            else {
                label.text = Strings.steps + ": 0"
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let startDateString = dateFormatter.string(from: interval.startDate)
        let endDateString = dateFormatter.string(from: interval.endDate)
        timeLabel.text = startDateString + " - " + endDateString
        timeLabel.textColor = UIColor.backgroundCompanionColor
    }
}
