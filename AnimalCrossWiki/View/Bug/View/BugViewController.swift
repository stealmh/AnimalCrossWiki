//
//  BugViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

protocol BugViewControllerDelegate: AnyObject {
    func didTapSetting(_ viewController: BugViewController)
}

class BugViewController: UIViewController {
    var disposeBag = DisposeBag()
    let viewModel = BugViewModel()
    
    weak var delegate: BugViewControllerDelegate?
    
    typealias Item = BugCell
    
    lazy var bugView: NewBugView = {
        let v: NewBugView = .fromNib()
        v.collectionView.register(Item.nib, forCellWithReuseIdentifier: Item.resueIdentifier)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(bugView)
        //MARK: 곤충데이터 불러오기
        Task { try await viewModel.getData() }
        //MARK: 레이아웃 구성
        bugView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        //MARK: 델리게이트 위임
        bugView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        //MARK: cell 구성
        viewModel.users.bind(to: bugView.collectionView.rx.items(cellIdentifier: Item.resueIdentifier, cellType: Item.self)) { row, item, cell in
            cell.bugLabel.text = "\(item.name)"
            
            
//            let _ = self.viewModel.loadImage(item.image_url)
//                .observe(on: MainScheduler.instance)
//                .subscribe(onNext: {data in
//                    cell.bugImage.image = data
//                })
            cell.bugImage.kf.indicatorType = .activity
            cell.bugImage.kf.setImage(with: URL(string: item.image_url))
            
        }.disposed(by: disposeBag)
        
        //MARK: 우리 섬 설정 버튼 클릭
        bugView.myInfoSettingButton.rx.tap
            .subscribe { data in
                self.delegate?.didTapSetting(self)
            }.disposed(by: disposeBag)
        
        //MARK: 전체보기 버튼 클릭
        bugView.allButton.rx.tap
            .subscribe(onNext:{
                //값이 일치하면 수행하지 않게
                if self.viewModel.users.value != self.viewModel.users_copy {
                    self.viewModel.users.accept(self.viewModel.users_copy)
                }
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag = DisposeBag()
        ImageCacheManager.shared.removeAllObjects()
    }
    
}

extension BugViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Item.Constant.size
    }
}

extension BugViewController: BugDelegate {
    func returnValue(vc: MyInfoViewController, south: Bool?, idx: Int?) {
        vc.dismiss(animated: true, completion: {[weak self] in
            if let south = south, let idx = idx {
                if south {
                    let a = self?.viewModel.users_copy.filter { $0.south.months_array.contains(idx + 1) }
                    self?.viewModel.users.accept(a!)
                }
                else {
                    let a = self?.viewModel.users_copy.filter { $0.north.months_array.contains(idx + 1) }
                    self?.viewModel.users.accept(a!)
                }
            }
        })
    }
}
