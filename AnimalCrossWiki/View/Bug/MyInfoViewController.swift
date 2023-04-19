//
//  MyInfoViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class MyInfoViewController: UIViewController {
    let dispose = DisposeBag()

    let defaultMonths = Observable.just(["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"])
    
    let buttonSelectOb: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let selectedIndex = PublishSubject<Int>()
    
    typealias Item = MyInfoSettingViewCell

    lazy var myView: MyInfoSettingView = {
        let v: MyInfoSettingView = .fromNib()
        v.collectionView.register(Item.nib, forCellWithReuseIdentifier: Item.resueIdentifier)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.isOpaque = false
        view.addSubview(myView)
        
        
        //대리자 설정
        myView.collectionView.rx.setDelegate(self)
            .disposed(by: dispose)
        
        //cell 구성
        self.defaultMonths.bind(to: myView.collectionView.rx.items(cellIdentifier: Item.resueIdentifier, cellType: Item.self)) { row, item, cell in
            cell.monthLabel.text = item
            
            self.selectedIndex.subscribe(onNext: {value in
                cell.backgroundColor =  value == row ? .red : .clear
            }).disposed(by: self.dispose)
            
        }
        .disposed(by: dispose)
        
        //레이아웃 구성
        myView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40)
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(view.frame.width - 80)
            $0.height.equalTo(400)
        }
        
        myView.northButton.rx.tap
            .subscribe(onNext: {_ in
                self.buttonSelectOb.accept(false)
            }).disposed(by: dispose)
        
        myView.southButton.rx.tap
            .subscribe(onNext: {_ in
                self.buttonSelectOb.accept(true)
            }).disposed(by: dispose)
        
        buttonSelectOb
            .subscribe(onNext: { south in
                if south {
                    self.myView.southButton.backgroundColor = .cyan
                    self.myView.northButton.backgroundColor = .clear
                }
                else {
                    self.myView.northButton.backgroundColor = .cyan
                    self.myView.southButton.backgroundColor = .clear
                }
            }).disposed(by: dispose)
        
        myView.okButton.rx.tap
            .subscribe(onNext: {_ in
                self.dismiss(animated: true)
            }).disposed(by: dispose)
        
        myView.collectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.selectedIndex.onNext(indexPath.row)
            }).disposed(by: dispose)
    }
}

extension MyInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Item.Constant.size
    }
}
