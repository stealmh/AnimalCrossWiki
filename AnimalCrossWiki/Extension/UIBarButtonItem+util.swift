//
//  UIBarButtonItem+util.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/15.
//

import UIKit

extension UIBarButtonItem {

    static func menuButton(_ target: Any?,
                           action: Selector,
                           imageName: String,
                           size:CGSize = CGSize(width: 100, height: 40)) -> UIBarButtonItem
    {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName)!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size.width).isActive = true

        return menuBarItem
    }
}
