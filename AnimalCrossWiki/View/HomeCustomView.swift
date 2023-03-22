//
//  HomeCustomView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/22.
//

import UIKit

final class HomeCustomView: UIView {
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "sun.max")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "가구"
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0/10023"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(frame: CGRect, myImage: UIImage, whatLabel: String, whatCount: String) {
        
        //Setup
        self.logoImage.image = myImage
        self.logoLabel.text = whatLabel
        self.countLabel.text = whatCount
        super.init(frame: frame)
        //Add
        self.backgroundColor = .gray
        self.addSubview(logoImage)
        self.addSubview(logoLabel)
        self.addSubview(countLabel)
        
        //Set layout
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayout() {
        
        //setup LogoImage
        logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        logoImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        logoImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        
        //setup LogoLabel
        logoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        logoLabel.topAnchor.constraint(equalTo: logoImage.topAnchor).isActive = true
        logoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        logoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        
        //setup countLabel
        countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    
}

import SwiftUI
struct MyYellowButtonPreview: PreviewProvider{
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
