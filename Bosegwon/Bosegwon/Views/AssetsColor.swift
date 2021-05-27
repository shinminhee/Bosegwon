//
//  File.swift
//  Bosegwon
//
//  Created by 신민희 on 2021/05/27.
//

import UIKit

enum AssetsColor {
    case mainColor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .mainColor:
            return #colorLiteral(red: 0.3350401819, green: 0.7853649259, blue: 0.8392842412, alpha: 1)
        }
    }
}



