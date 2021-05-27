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
            return #colorLiteral(red: 0.3098039216, green: 0.7137254902, blue: 0.7607843137, alpha: 1)
        }
    }
}



