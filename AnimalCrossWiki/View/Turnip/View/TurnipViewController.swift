//
//  TurnipViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/18.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift


///Only Programmatically
class TurnipViewController: UIViewController {
    
    private let turnipView = TurnipView()
    private let resultButton: UIButton = {
        let v = UIButton()
        v.setTitle("결과확인", for: .normal)
        v.backgroundColor = UIColor(named: "sky")
        return v
    }()
    
    let disposeBag = DisposeBag()
//    let turnipViewModel = TurnipVieModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(turnipView)
        view.addSubview(resultButton)
        
        turnipView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2)
        }
        resultButton.snp.makeConstraints {
            $0.top.equalTo(turnipView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
        }
        navigationSetting()
    }
}

//MARK: -
extension TurnipViewController {
    func navigationSetting() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.rightBarButtonItems =
        [UIBarButtonItem.menuButton(name: "초기화", color: .black, cornerRadius: 20),
         UIBarButtonItem.menuButton(name: "저장", color: .black, cornerRadius: 20)]
    }
}


import SwiftUI
struct ViewController2312_preview: PreviewProvider {
    static var previews: some View {
        TurnipViewController().toPreview()
    }
}

