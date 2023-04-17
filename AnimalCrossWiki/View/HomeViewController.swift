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
        return view
    }()
    
    private let bugView: HomeCustomView = {
        let view = HomeCustomView(frame: .zero, myImage: UIImage(systemName: "ladybug")!, whatLabel: "안뇽", whatCount: "3/200")
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
    }
}

import SwiftUI
struct ViewControsller_preview: PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
