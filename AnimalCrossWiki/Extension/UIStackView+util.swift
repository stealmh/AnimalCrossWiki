//
//  UIStackView+util.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/30.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
