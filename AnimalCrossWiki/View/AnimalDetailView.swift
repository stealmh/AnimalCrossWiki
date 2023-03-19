//
//  AnimalDetailView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/19.
//

import UIKit

class AnimalDetailView: UIViewController {
    
    let animalName: UILabel = {
        let label = UILabel()
        label.text = "뽀삐"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(animalName)
        animalName.translatesAutoresizingMaskIntoConstraints = false
        animalName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animalName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
