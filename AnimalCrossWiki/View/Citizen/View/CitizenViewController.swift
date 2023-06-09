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
import Kingfisher

protocol CitizenViewControllerDelegate: AnyObject {
    func didTapCell(_ viewController: CitizenViewController, data: ControlEvent<AnimalModel>.Element)
}

class CitizenViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel: CitizenViewModel
    
    weak var delegate: CitizenViewControllerDelegate?
    
    typealias Item = CitizenTableViewCell
    
    private let citizenView: NewCitizenView = {
        let v: NewCitizenView = .fromNib()
        v.tableView.register(Item.nib, forCellReuseIdentifier: Item.reuseIdentifier)
        return v
    }()
    
    init(viewModel: CitizenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 로고 버튼 탭
    @objc func didLogoTapped() {
        self.viewModel.isPaginating = false
        self.viewModel.users.accept(self.viewModel.forLogoTouchData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        viewSetting()
        navigationSetting()
        bindViewModel()
        citizenView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.users
            .distinctUntilChanged()
            .bind(to: citizenView.tableView.rx.items(cellIdentifier: Item.reuseIdentifier,cellType: Item.self)) { row, item, cell in
                
                cell.citizenLabel.text = "\(item.name)"
                cell.citizenTypeLabel.text = item.species
                cell.citizenFavoriteButton.setImage(UIImage(systemName: CoreDataManager.shared.fetch(animalName: item.name) ? "heart.fill" : "heart"), for: .normal)
                
                cell.citizenImage.kf.indicatorType = .activity
                cell.citizenImage.kf.setImage(with: URL(string: item.image_url))
                
                
                /// Todo : 즐겨찾기 수정하기
                cell.citizenFavoriteButton.rx.tap
                    .map { CoreDataManager.shared.fetch(animalName: item.name) }
                    .subscribe(onNext: {isExist in
                        if isExist {
                            // 이미 즐겨찾기 한 상태에서 터치가 들어옴
                            // 1.데이터를 삭제
                            CoreDataManager.shared.delete(animalName: item.name)
                            // 2.버튼의 색깔 바꾸기
                            cell.citizenFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                            
                        } else {
                            // 1.데이터를 추가
                            CoreDataManager.shared.insertContent(content: item)
                            // 2.버튼의 색깔 바꾸기
                            cell.citizenFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        }
                    }).disposed(by: cell.disposeBag)
                
                
            }.disposed(by: disposeBag)
        
        citizenView.tableView.rx.modelSelected(AnimalModel.self)
            .subscribe(onNext: {data in
                self.delegate?.didTapCell(self, data: data)
            }).disposed(by: disposeBag)

        self.navigationItem.searchController?.searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { _ in
                Task {
                    try await self.viewModel.getData()
                }
            }).disposed(by: disposeBag)
        
    }
    
    func bindViewModel() {
        let input = CitizenViewModel.Input(showFavoriteButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap,
                                           searchText: navigationItem.searchController!.searchBar.rx.text.orEmpty.asObservable())

        let output = viewModel.transform(input: input)
        
//        output.showFavoriteButtonTapped.bind(onNext: {data in
//            self.viewModel.users.accept(data)
//        }).disposed(by: disposeBag)
        
    }
}


extension CitizenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Item.Constant.size.height
    }
}

//MARK: Method
extension CitizenViewController {
    
    func getData() {
        Task {
            
            let a = LoadingViewController()
            a.modalPresentationStyle = .fullScreen
            self.present(a, animated: false)
            try await viewModel.getData1()
            viewModel.fetchData(pagination: false, completion: {[weak self] result in
                switch result {
                case .success(let data):
                    self?.viewModel.users.accept(data)
                    DispatchQueue.main.async {
                        self?.dismiss(animated: false)
                    }
                default:
                    return
                }
            })
            
            citizenView.tableView.rx.contentOffset
                .map { self.isScrolledToBottom($0, self.citizenView.tableView) }
                .subscribe(onNext: { data in
                    if data {
//                        LoadingIndicator.showLoading()
                        guard !self.viewModel.isPaginating else { return }
                        print("reload!!")
                        self.viewModel.fetchData(pagination: true, completion: { [weak self] result in
                            switch result {
                            case .success(let moreData):
                                let array = Array(Set(moreData).sorted { $0.name < $1.name })
                                for i in array {
//                                    print(i.name)
                                    guard let self else {return}
                                    if !self.viewModel.users.value.contains(i) {
                                        self.viewModel.users.add(element: i)
                                    }
//                                    LoadingIndicator.hideLoading()
                                }
                            default:
                                return
                            }
                        })
                    }
                }).disposed(by: disposeBag)
        }
        
        
    }
    
    func viewSetting() {
        view.backgroundColor = .white
        view.addSubview(citizenView)
        
        citizenView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func navigationSetting() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(didLogoTapped), imageName: "logo")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(didLogoTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .systemPink
        
        self.navigationItem.searchController = UISearchController()
        self.navigationItem.searchController?.searchBar.placeholder = "주민을 검색하세요!"
    }
}


