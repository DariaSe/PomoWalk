//
//  MenuTableViewCell.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "dropDownCell"
    
    let shadowingView = UIView()
    let stackView = UIStackView()
    let optionTextField = UITextField()
    let checkmarkLabel = UILabel()
    
    var isEditable: Bool = false {
        didSet {
            optionTextField.isUserInteractionEnabled = isEditable
            if isEditable {
                optionTextField.becomeFirstResponder()
            }
        }
    }

    var textChanged: ((String) -> Void)?
    
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
        stackView.constrainToEdges(of: contentView, leading: 5, trailing: 15, top: 5, bottom: 5)
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.addArrangedSubview(optionTextField)
        stackView.addArrangedSubview(checkmarkLabel)
        
        optionTextField.textColor = UIColor.walkCounterColor
        optionTextField.font = UIFont.stepperUnitFont
        optionTextField.delegate = self
        optionTextField.returnKeyType = .done
        optionTextField.layer.cornerRadius = 10
        optionTextField.setLeftPaddingPoints(10)
        optionTextField.autocapitalizationType = .sentences
        
        checkmarkLabel.textColor = UIColor.walkCounterColor
        checkmarkLabel.font = UIFont.stepperUnitFont
        checkmarkLabel.text = "\u{2713}"
        checkmarkLabel.setWidth(equalTo: 16)
    }
    
    func update(text: String, isSelected: Bool) {
        optionTextField.text = text
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
        optionTextField.textColor = UIColor.walkCounterColor
        checkmarkLabel.textColor = UIColor.walkCounterColor
    }
}

extension MenuTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        contentView.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textChanged?(textField.text ?? "")
        textField.backgroundColor = UIColor.clear
    }
}
