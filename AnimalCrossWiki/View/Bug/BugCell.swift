//
//  BugCell.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/18.
//

import UIKit

class BugCell: UICollectionViewCell {
    
    @IBOutlet weak var bugImage: UIImageView!
    @IBOutlet weak var bugLabel: UILabel!
    
    enum Constant {
      static let size: CGSize = .init(width: 85, height: 85)
    }
    
    override func awakeFromNib() {
        
    }
}
