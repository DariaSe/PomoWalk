//
//  BadgesCollectionReusableView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 18.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class BadgesCollectionReusableView: UICollectionReusableView {
    
    static let reuseIdentifier = "BadgesHeader"
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        label.constrainToEdges(of: self, leading: 0, trailing: 10, top: nil, bottom: 20)
        label.font = UIFont.settingsTextFont
        label.adjustsFontSizeToFitWidth = true
    }
}
