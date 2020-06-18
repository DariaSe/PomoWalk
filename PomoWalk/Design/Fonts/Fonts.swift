//
//  Fonts.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 10.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

let anonymousProBold = "AnonymousPro-Bold"
let sourceCodeProBlack = "SourceCodePro-Black"

let montserratSemiBold = "Montserrat-SemiBold"
let montserratBold = "Montserrat-Bold"

extension UIFont {
    static let timerFont = UIFont(name: sourceCodeProBlack, size: 28)
    static let stepperUnitFont = UIFont(name: montserratBold, size: 16)
    static var settingsTextFont: UIFont? {
        if UIScreen.main.bounds.width < 375 {
            return UIFont(name: montserratBold, size: 12)
        }
        else {
            return UIFont(name: montserratBold, size: 14)
        }
    }
//    static let settingsTextFont = UIFont(name: montserratBold, size: 14)
    static let buttonsFont = UIFont(name: montserratSemiBold, size: 16)
}
