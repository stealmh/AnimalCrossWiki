//
//  CollectionViewCell.swift
//  CompoPractice
//
//  Created by 김민호 on 2023/05/31.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    let imageView: UIImageView = {
        let v = UIImageView()
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        
        ///Todo: 이미지 명함 줄지 말지.. 고민중
//        v.layer.shadowOffset = CGSize(width: 5, height: 5)
//        v.layer.shadowOpacity = 0.7
//        v.layer.shadowRadius = 5
//        v.layer.shadowColor = UIColor.gray.cgColor
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        let images: [UIImage] = [UIImage(named: "logo")!]
        imageView.image = images.first!
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds.insetBy(dx: 10, dy: 10)
    }
}
