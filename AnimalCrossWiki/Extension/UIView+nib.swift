//
//  UIView+nib.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/04/13.
//

import UIKit


extension UIView {
  class var nibName: String { String(describing: Self.self) }
  class var nib: UINib { UINib(nibName: nibName, bundle: nil) }
  
  class func fromNib<T: UIView>() -> T {
    return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
}
