//
//  FishViewController.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/04/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit



class FishViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    let myData = BehaviorRelay<[Fish]>(value: [])
    
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
        view.addSubview(fishView)
        Task {
            try await self.getFish()
        }
        fishView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.bottom.right.equalToSuperview()
        }
        bindTableView()
    }
    
    func bindTableView() {
        fishView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        myData
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
    
    
    
    func getFish() async throws {
        print(#function)
        let url = URL(string: "https://api.nookipedia.com/nh/fish")
        let version: String = "1.5.0"
        let myKey = "4a59aa18-04df-4cae-9a40-6b97b7a29216"
        var request = URLRequest(url: url!)
        
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        var result = try JSONDecoder().decode([Fish].self, from: data)
        result.sort { $0.number < $1.number }
        result.indices.filter{result[$0].location == "Pond"}.forEach{ result[$0].location = "연못" }
        result.indices.filter{result[$0].location == "River"}.forEach{ result[$0].location = "강" }
        result.indices.filter{result[$0].location == "Sea"}.forEach{ result[$0].location = "바다" }
        result.indices.filter{result[$0].location == "River (clifftop)"}.forEach{ result[$0].location = "강(절벽위)" }
        result.indices.filter{result[$0].location == "River (mouth)"}.forEach{ result[$0].location = "강(하구)" }
        result.indices.filter{result[$0].location == "Pier"}.forEach{ result[$0].location = "부두" }
        result.indices.filter{result[$0].location == "Sea (raining)"}.forEach{ result[$0].location = "바다(비)" }
        myData.accept(result)
//        items = result
//        print(items.count)
        
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
