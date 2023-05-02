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
        
        Task {
            try await viewModel.getFish()
            viewModel.filterFish()
        }
        fishView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            
            make.left.bottom.right.equalToSuperview()
        }
        
        bindTableView()
        
        fishView.positionSortButton.rx.tap
            .bind {
                var sortValue = self.viewModel.myData.value
                sortValue.sort { data1, data2 in
                    data1.location.count > data2.location.count
                }
                self.viewModel.myData.accept(sortValue)
                print("tapped")
            }.disposed(by: disposeBag)
        
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
        
        
    }
    
    private func bindTableView() {
        fishView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.myData
            .bind(to: fishView.tableView.rx.items(cellIdentifier: Item.reuseIdentifier, cellType: Item.self)) {row, item, cell in
            cell.numberLabel.text = "\(item.number)"
    //        cell.fishImageView.image =
            if let url = URL(string: item.image_url) {
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    guard let data,
                          let newImage = UIImage(data: data) else {return}
                    DispatchQueue.main.async {
                        cell.fishImageView.image = newImage
                    }
                }
                task.resume()
            }
            cell.fishLocationLabel.text = item.location
            cell.fishNameLabel.text = item.name
            cell.fishPriceLabel.text = "\(item.sell_nook)"
        }.disposed(by: disposeBag)
    }
}


extension FishViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Header.Constant.size.height
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = tableView.dequeueReusableHeaderFooterView(withIdentifier: Header.reuseIdentifier) as! Header
        return v
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Header.Constant.size.height
    }
}

