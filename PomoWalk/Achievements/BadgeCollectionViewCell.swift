//
//  BadgeCollectionViewCell.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 18.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "BadgeCell"
    
    let badgeView = BadgeView()
    let badgeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        badgeView.pinToEdges(to: contentView)
        badgeLabel.center(in: contentView)
        badgeLabel.font = UIFont.badgeFont
        badgeLabel.textAlignment = .center
    }
    
    func update(with badge: Badge) {
        contentView.backgroundColor = UIColor.backgroundColor
        badgeLabel.text = badge.title
        badgeView.percent = badge.currentNumber.cgFloat / badge.maxNumber.cgFloat
        badgeView.backgroundColor = UIColor.clear
        badgeView.counterColor = UIColor.walkCounterColor
        badgeView.traceColor = UIColor.walkCounterColor.withAlphaComponent(0.3)
        badgeLabel.textColor = badge.isCompleted ? UIColor.textColor : UIColor.lightGray.withAlphaComponent(0.5)
    }
}
