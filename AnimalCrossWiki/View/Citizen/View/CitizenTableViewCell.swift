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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        print(disposeBag)
        self.disposeBag = DisposeBag()
        citizenImage.image = nil
        citizenLabel.text = nil
        citizenTypeLabel.text = nil
        citizenFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        updateLayout()
    }
    
    func updateLayout() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}

