//
//  FishViewCell.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/13.
//

import UIKit

final class FishViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var fishImageView: UIImageView!
    @IBOutlet weak var fishNameLabel: UILabel!
    @IBOutlet weak var fishPriceLabel: UILabel!
    @IBOutlet weak var fishLocationLabel: UILabel!
    
    override class func awakeFromNib() {
        
    }
}