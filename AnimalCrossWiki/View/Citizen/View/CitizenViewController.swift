//
//  CitizenViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol CitizenViewControllerDelegate: AnyObject {
    func didTapCell(_ viewController: CitizenViewController, data: ControlEvent<AnimalModel>.Element)
}

class CitizenViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    weak var delegate: CitizenViewControllerDelegate?
    
    typealias Item = CitizenTableViewCell
    
    private let citizenView: NewCitizenView = {
        let v: NewCitizenView = .fromNib()
        v.tableView.register(Item.nib, forCellReuseIdentifier: Item.reuseIdentifier)
        return v
    }()
    
    
    @objc func dd() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(citizenView)
        
        Task {
            try await viewModel.getData()
        }
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "sky")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(dd))
        self.navigationController?.navigationBar.topItem?.title = "주민목록"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.layer.cornerRadius = 30
        self.navigationController?.navigationBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        citizenView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        
        citizenView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.users.bind(to: citizenView.tableView.rx.items(cellIdentifier: Item.reuseIdentifier,cellType: Item.self)) { row, item, cell in
            cell.citizenLabel.text = "\(item.name)"
            cell.citizenTypeLabel.text = item.species
            cell.citizenFavoriteButton.setImage(UIImage(systemName: CoreDataManager.shared.fetch(animalName: item.name) ? "star.fill" : "star"), for: .normal)
            //            cell.citizenImage.setImageUrl(item.image_url)
            
            let _ = self.viewModel.loadImage(item.image_url)
                .observe(on: MainScheduler.instance)
                .bind(to: cell.citizenImage.rx.image)
            
            let _ = cell.citizenFavoriteButton.rx.tap
                .map { CoreDataManager.shared.fetch(animalName: item.name) }
                .subscribe(onNext: {isExist in
                    if isExist {
                        // 이미 즐겨찾기 한 상태에서 터치가 들어옴
                        // 1.데이터를 삭제
                        CoreDataManager.shared.delete(animalName: item.name)
                        // 2.버튼의 색깔 바꾸기
                        cell.citizenFavoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                        
                    } else {
                        // 1.데이터를 추가
                        CoreDataManager.shared.insertContent(content: item)
                        // 2.버튼의 색깔 바꾸기
                        cell.citizenFavoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    }
                })
            
        }.disposed(by: disposeBag)
        
        citizenView.tableView.rx.modelSelected(AnimalModel.self)
            .subscribe(onNext: {data in
                self.delegate?.didTapCell(self, data: data)
            }).disposed(by: disposeBag)
        
        //        citizenView.testCheckButton.rx.tap
        //            .subscribe(onNext: {_ in
        //                self.viewModel.users.accept(CoreDataManager.shared.fetch())
        //            }).disposed(by: disposeBag)
    }
}


extension CitizenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Item.Constant.size.height
    }
}
