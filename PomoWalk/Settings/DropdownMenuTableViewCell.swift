//
//  DropdownMenuTableViewCell.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class DropdownMenuTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "dropDownCell"
    
    let shadowingView = UIView()
    let stackView = UIStackView()
    let optionLabel = UILabel()
    let checkmarkLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func initialSetup() {
        contentView.backgroundColor = UIColor.backgroundColor
        shadowingView.pinToEdges(to: contentView)
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        stackView.pinToLayoutMargins(to: contentView)
        stackView.axis = .horizontal
        stackView.addArrangedSubview(optionLabel)
        stackView.addArrangedSubview(checkmarkLabel)
        
        optionLabel.textColor = UIColor.walkCounterColor
        optionLabel.font = UIFont.stepperUnitFont
        
        checkmarkLabel.textColor = UIColor.walkCounterColor
        checkmarkLabel.font = UIFont.stepperUnitFont
        checkmarkLabel.text = "\u{2713}"
    }
    
    func update(text: String, isSelected: Bool) {
        optionLabel.text = text
        checkmarkLabel.alpha = isSelected ? 1.0 : 0.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view = UIView()
        view.frame = contentView.bounds
        view.backgroundColor = UIColor.backgroundColor
        selectedBackgroundView = view
    }
    
    func setupColors() {
        contentView.backgroundColor = UIColor.backgroundColor
        optionLabel.textColor = UIColor.walkCounterColor
        checkmarkLabel.textColor = UIColor.walkCounterColor
    }
}
