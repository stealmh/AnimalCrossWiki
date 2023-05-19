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

protocol TurnipViewControllerDelegate: AnyObject {
    func didTapResultButton(data: Turnip)
}

///Only Programmatically
class TurnipViewController: UIViewController {
    
    weak var delegate: TurnipViewControllerDelegate?
    let disposeBag = DisposeBag()
    var simpleData: String = ""
    let viewModel = TurnipViewModel()
    
    private let turnipView = TurnipView()
    private let resultButton: UIButton = {
        let v = UIButton()
        v.setTitle("결과확인", for: .normal)
        v.backgroundColor = UIColor(named: "sky")
        return v
    }()

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
        observeTextField()
        
        resultButton.rx.tap
            .subscribe(onNext: { _ in
                let a: [UITextField] = [self.turnipView.sunPrice,
                                        self.turnipView.monAmPrice, self.turnipView.monPmPrice,
                                        self.turnipView.tueAmPrice, self.turnipView.tuePmPrice,
                                        self.turnipView.wedAmPrice, self.turnipView.wedPmPrice,
                                        self.turnipView.thurAmPrice, self.turnipView.thurPmPrice,
                                        self.turnipView.friAmPrice, self.turnipView.friPmPrice,
                                        self.turnipView.satAmPrice]
                
                for i in a {
                    self.simpleData += "\(i.text ?? "0")-"
                }
                Task {
                    let turnip = try await self.viewModel.getTurnipResult(parameter: self.simpleData)
                    self.simpleData = ""
                    self.delegate?.didTapResultButton(data: turnip)
                }
                
            }).disposed(by: disposeBag)
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
    
    func observeTextField() {
        turnipView.sunPrice.rx.text.orEmpty
            .map { $0.isValid }
            .subscribe(onNext: { text in
                print(text)
            }).disposed(by: disposeBag)
    }
}
