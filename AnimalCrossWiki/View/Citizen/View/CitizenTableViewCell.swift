//
//  CitizenTableViewCell.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/21.
//

import UIKit
import RxCocoa
import RxSwift

class CitizenTableViewCell:UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var citizenImage: UIImageView!
    @IBOutlet weak var citizenLabel: UILabel!
    @IBOutlet weak var citizenTypeLabel: UILabel!
    @IBOutlet weak var citizenFavoriteButton: UIButton!
    
    enum Constant {
        static let size: CGSize = .init(width: 60, height: 55)
    }
    
    override class func awakeFromNib() {
        
    }
    
    override func prepareForReuse() {
        self.citizenImage.image = nil
        self.citizenLabel.text = nil
        self.citizenTypeLabel.text = nil
    }
//    
//    func updateLayout() {
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//    }
    
}

