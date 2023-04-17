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



class FishViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    let myData = BehaviorRelay<[Fish]>(value: [])
    
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
            try await self.getFish()
        }
        fishView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            
            make.left.bottom.right.equalToSuperview()
        }
        
        bindTableView()
        fishView.positionSortButton.rx.tap
            .bind {
                var sortValue = self.myData.value
                sortValue.sort { data1, data2 in
                    data1.location.count > data2.location.count
                }
                self.myData.accept(sortValue)
            }.disposed(by: disposeBag)
        
        fishView.priceSortButton.rx.tap
            .bind {
                if self.toggleCheck {
                    var sortValue = self.myData.value
                    sortValue.sort { data1, data2 in
                        data1.sell_nook < data2.sell_nook
                    }
                    self.myData.accept(sortValue)
                    self.toggleCheck.toggle()
                }
                else {
                    var sortValue = self.myData.value
                    sortValue.sort { data1, data2 in
                        data1.sell_nook > data2.sell_nook
                    }
                    self.myData.accept(sortValue)
                    self.toggleCheck.toggle()
                }
            }.disposed(by: disposeBag)
        
        
    }
    
    private func bindTableView() {
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
 
    private func getFish() async throws {
        print(#function)
        let url = URL(string: "https://api.nookipedia.com/nh/fish")
        let version: String = "1.5.0"
        let myKey = Bundle.main.apiKey
        var request = URLRequest(url: url!)
        
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        var result = try JSONDecoder().decode([Fish].self, from: data)
        result.sort { $0.number < $1.number }
        let filterMyFish = self.filterFish(result)
        myData.accept(filterMyFish)
        
    }
    
    private func filterFish(_ fish: [Fish]) -> [Fish] {
        
        var myFish = fish
        
        myFish.indices.forEach { idx in
            
            let fishCase = myFish[idx].location
            switch fishCase {
            case FishCase.Pond.rawValue:
                myFish[idx].location = "연못"
            case FishCase.River.rawValue:
                myFish[idx].location = "강"
            case FishCase.Sea.rawValue:
                myFish[idx].location = "바다"
            case FishCase.RiverClifftop.rawValue:
                myFish[idx].location = "강(절벽위)"
            case FishCase.RiverMouth.rawValue:
                myFish[idx].location = "강(하구)"
            case FishCase.Pier.rawValue:
                myFish[idx].location = "부두"
            case FishCase.SeaRain.rawValue:
                myFish[idx].location = "바다(비)"
            default:
                break
            }
        }
        return myFish
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

