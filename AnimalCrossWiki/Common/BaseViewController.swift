//
//  BaseViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

//class BaseViewController<V: UIView>: UIViewController
    
class BaseViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    
//    lazy var genericView = V()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view = genericView
//        view.backgroundColor = .white
//
//        view.addSubview(genericView)
//        genericView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.left.right.bottom.equalToSuperview()
//        }

    }
}
