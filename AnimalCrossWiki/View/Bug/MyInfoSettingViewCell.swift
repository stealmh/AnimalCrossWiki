//
//  MyInfoSettinViewCell.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/19.
//

import UIKit

class MyInfoSettingViewCell: UICollectionViewCell {
    
    enum Constant {
      static let size: CGSize = .init(width: 60, height: 55)
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    override class func awakeFromNib() {
        
    }
}
