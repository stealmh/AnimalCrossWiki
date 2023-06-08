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

class BugViewController: UIViewController {
    var disposeBag = DisposeBag()
    let viewModel: BugViewModel!
    
    weak var delegate: BugViewControllerDelegate?
    
    typealias Item = BugCell
    
    lazy var bugView: NewBugView = {
        let v: NewBugView = .fromNib()
        v.collectionView.register(Item.nib, forCellWithReuseIdentifier: Item.resueIdentifier)
        return v
    }()
    
    init(viewModel: BugViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        bind()
        //MARK: 델리게이트 위임
        bugView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        //MARK: cell 구성
        viewModel.users.bind(to: bugView.collectionView.rx.items(cellIdentifier: Item.resueIdentifier, cellType: Item.self)) { row, item, cell in
            
            cell.bugLabel.text = "\(item.name)"
            cell.bugImage.kf.indicatorType = .activity
            cell.bugImage.kf.setImage(with: URL(string: item.image_url))
            
        }.disposed(by: disposeBag)
        
        //MARK: 우리 섬 설정 버튼 클릭
        bugView.myInfoSettingButton.rx.tap
            .subscribe { data in
                self.delegate?.didTapSetting(self)
            }.disposed(by: disposeBag)
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        disposeBag = DisposeBag()
//        ImageCacheManager.shared.removeAllObjects()
//    }
    
}

extension BugViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Item.Constant.size
    }
}

//MARK: - Method
extension BugViewController {
    private func bind() {
        let input = BugViewModel.Input(allButtonTapped: bugView.allButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.allButtonTappedResult.bind(onNext: {data in
            print(data)
            self.viewModel.users.accept(data)
        }).disposed(by: disposeBag)
    }
}

