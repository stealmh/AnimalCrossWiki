//
//  UIView+nib.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/13.
//

import UIKit


extension UIView {
  static var nibName: String { String(describing: Self.self) }
  static var nib: UINib { UINib(nibName: nibName, bundle: nil) }
  
  static func fromNib<T: UIView>() -> T {
    return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
}
