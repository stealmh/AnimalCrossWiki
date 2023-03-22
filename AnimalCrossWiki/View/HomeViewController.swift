//
//  HomeViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    let fishView: HomeCustomView = {
        let view = HomeCustomView(frame: .zero, myImage: UIImage(systemName: "person")!, whatLabel: "물고기", whatCount: "0/100")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bugView: HomeCustomView = {
        let view = HomeCustomView(frame: .zero, myImage: UIImage(systemName: "ladybug")!, whatLabel: "안뇽", whatCount: "3/200")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fishView)
        view.addSubview(bugView)
        makeMyView()
    }
    
    func makeMyView() {
        
        //make fish Section
        fishView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        fishView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        fishView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //make bug Section
        bugView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
        bugView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bugView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

import SwiftUI
struct ViewControsller_preview: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
