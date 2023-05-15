//
//  FishViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FishViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = FishViewModel()
    
    private var toggleCheck: Bool = false
    
    typealias Header = FishViewHeader
    typealias Item = FishViewCell
    
    lazy var fishView: NewFishView = {
        let v: NewFishView = .fromNib()
        v.tableView.register(Item.nib, forCellReuseIdentifier: Item.reuseIdentifier)
        v.tableView.register(Header.nib, forHeaderFooterViewReuseIdentifier: Header.reuseIdentifier)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(fishView)
        
        //MARK: 데이터 가져오기
        Task {
            try await viewModel.getFish()
            viewModel.filterFish(value: self.viewModel.myData)
        }
        //MARK: 레이아웃 구성
        fishView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.bottom.right.equalToSuperview()
        }
        //MARK: 테이블 뷰 관련 세팅
        tableViewSetting()
        //MARK: 위치버튼 눌렀을 때 액션
        fishView.positionSortButton.rx.tap
            .bind {
                var sortValue = self.viewModel.myData.value
                sortValue.sort { data1, data2 in
                    data1.location.count > data2.location.count
                }
                self.viewModel.myData.accept(sortValue)
            }.disposed(by: disposeBag)
        //MARK: 가격버튼 눌렀을 때 액션
        fishView.priceSortButton.rx.tap
            .bind {_ in
                if self.toggleCheck {
                    var sortValue = self.viewModel.myData.value
                    sortValue.sort { data1, data2 in
                        data1.sell_nook < data2.sell_nook
                    }
                    self.viewModel.myData.accept(sortValue)
                    self.toggleCheck.toggle()
                }
                else {
                    var sortValue = self.viewModel.myData.value
                    sortValue.sort { data1, data2 in
                        data1.sell_nook > data2.sell_nook
                    }
                    self.viewModel.myData.accept(sortValue)
                    self.toggleCheck.toggle()
                }
            }.disposed(by: disposeBag)
        //MARK: 전체보기 버튼 눌렀을 때 액션
        fishView.clearButton.rx.tap
            .subscribe(onNext: {_ in
//                self.viewModel.myData.accept(self.viewModel.defaultData)
                self.viewModel.filterFish(value: self.viewModel.defaultData)
            }).disposed(by: disposeBag)
        
        
    }
    
    private func tableViewSetting() {
        fishView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.myData
            .bind(to: fishView.tableView.rx.items(cellIdentifier: Item.reuseIdentifier, cellType: Item.self)) {row, item, cell in
                
//            let _ = self.viewModel.loadImage(item.image_url)
//                .observe(on: MainScheduler.instance)
//                .bind(to: cell.fishImageView.rx.image)
            cell.fishImageView.setImageUrl(item.image_url)
            cell.numberLabel.text = "\(item.number)"
            cell.fishLocationLabel.text = item.location
            cell.fishNameLabel.text = item.name
            cell.fishPriceLabel.text = "\(item.sell_nook)"
                
        }.disposed(by: disposeBag)
    }
}


extension FishViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Header.Constant.size.height
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = tableView.dequeueReusableHeaderFooterView(withIdentifier: Header.reuseIdentifier) as! Header
        return v
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Item.Constants.size.height
    }
}

