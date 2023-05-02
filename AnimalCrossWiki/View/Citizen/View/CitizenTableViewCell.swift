//
//  CitizenTableViewCell.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/21.
//

import UIKit

class CitizenTableViewCell:UITableViewCell {
    
    @IBOutlet weak var citizenImage: UIImageView!
    @IBOutlet weak var citizenLabel: UILabel!
    @IBOutlet weak var citizenTypeLabel: UILabel!
    
    enum Constant {
        static let size: CGSize = .init(width: 60, height: 55)
    }
    
    override class func awakeFromNib() {
        
    }
    
}

