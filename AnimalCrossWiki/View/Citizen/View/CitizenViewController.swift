//
//  CitizenViewController.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/04/21.
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(citizenView)
        
        Task {
            try await viewModel.getData()
        }
        
        citizenView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        
        citizenView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.users.bind(to: citizenView.tableView.rx.items(cellIdentifier: Item.reuseIdentifier,cellType: Item.self)) { row, item, cell in
            cell.citizenLabel.text = "\(item.name)"
            
            let _ = self.viewModel.loadImage(item.image_url)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: {data in
                    cell.citizenImage.image = data
                })
        }.disposed(by: disposeBag)
        
        citizenView.tableView.rx.modelSelected(AnimalModel.self)
            .subscribe(onNext: {data in
                self.delegate?.didTapCell(self, data: data)
            }).disposed(by: disposeBag)
        
        
    }
}


extension CitizenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
