//
//  HomeViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit

class HomeViewController: UIViewController {

    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "hello world!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testLabel)
        textLayout()
        view.backgroundColor = .white
    }
    
    func textLayout() {
        
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}
