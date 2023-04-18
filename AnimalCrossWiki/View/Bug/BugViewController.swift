//
//  BugViewController.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/04/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BugViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = BugViewModel()
    
    typealias Item = BugCell
    
    lazy var bugView: NewBugView = {
        let v: NewBugView = .fromNib()
        v.collectionView.register(Item.nib, forCellWithReuseIdentifier: Item.resueIdentifier)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            try await viewModel.getData()
        }
        view.backgroundColor = .white
        view.addSubview(bugView)
        
        bugView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        
        bugView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        viewModel.users.bind(to: bugView.collectionView.rx.items(cellIdentifier: Item.resueIdentifier, cellType: Item.self)) { row, item, cell in
            cell.bugLabel.text = "\(item.name)"
            
            let _ = self.viewModel.loadImage(item.image_url)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: {data in
                    cell.bugImage.image = data
                })
        }
        .disposed(by: disposeBag)
        
    }
}

extension BugViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Item.Constant.size
    }
}
