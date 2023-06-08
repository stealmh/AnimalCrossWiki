//
//  LoadingViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/06/02.
//

import UIKit
import SnapKit
import Then

final class LoadingViewController: UIViewController {
    
    private let myView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    private let developerLabel = UILabel().then {
        $0.text = "developer 김민호"
        $0.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myView)
        view.addSubview(developerLabel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.developerLabel.isHidden.toggle()
        }
        
        myView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(130)
        }
        
        developerLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
    }
}

import SwiftUI
struct ViewController1_preview: PreviewProvider {
    static var previews: some View {
        LoadingViewController().toPreview()
    }
}
