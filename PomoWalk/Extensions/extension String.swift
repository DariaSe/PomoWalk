//
//  extension String.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
