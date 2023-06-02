//
//  LoadingViewController.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/06/02.
//

import UIKit
import SnapKit

class LoadingViewController: UIViewController {
    
    private let myView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "logo")
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myView)
        
        myView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(130)
        }
    }
}

import SwiftUI
struct ViewController1_preview: PreviewProvider {
    static var previews: some View {
        LoadingViewController().toPreview()
    }
}
