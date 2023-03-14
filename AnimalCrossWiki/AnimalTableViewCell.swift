//
//  AnimalTableViewCell.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {
    static let identifier = "AnimalTableViewCell"
    
    let photo = CustomImageView()
    
    let name: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        photo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        name.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 20).isActive = true
    }
    
}

import SwiftUI
struct ViewController_preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
