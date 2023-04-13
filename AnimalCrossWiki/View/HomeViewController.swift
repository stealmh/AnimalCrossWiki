//
//  HomeViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HomeViewController: UIViewController {
    
    private let fishView: HomeCustomView = {
        let view = HomeCustomView(frame: .zero, myImage: UIImage(systemName: "person")!, whatLabel: "물고기", whatCount: "0/100")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bugView: HomeCustomView = {
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
        fishView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.right.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(100)
            make.top.equalToSuperview().inset(150)
        }
        
        bugView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.centerX).offset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(100)
            make.top.equalToSuperview().inset(150)
        }
        
        
//        fishView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        fishView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
//        fishView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        fishView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
        //make bug Section
//        bugView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
//        bugView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//        bugView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        bugView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
    }
}

import SwiftUI
struct ViewControsller_preview: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
