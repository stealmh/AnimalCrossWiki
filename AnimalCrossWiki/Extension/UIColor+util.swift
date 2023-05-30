//
//  UIColor+util.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/30.
//

import UIKit

extension UIColor {
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
