//
//  ViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import UIKit
import RxSwift
import RxCocoa
import DropDown

class ViewController: UIViewController, UITableViewDelegate {

    private let viewModel = ViewModel()
    let disposebag = DisposeBag()
    
    //MARK: View
    private let header: CustomHeaderView = {
        let hd = CustomHeaderView()
        hd.translatesAutoresizingMaskIntoConstraints = false
        return hd
    }()
    private let tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.identifier)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        headerSetting()
        naivationSetting()
        tableViewSetting()
        
        Task {
            try await viewModel.getData()
            tableView.reloadData()
            bindTableView()
        }
        tableViewCellTapped()
        filterDataInjection()
    }
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposebag)
        viewModel.users.bind(to: tableView.rx.items(cellIdentifier: AnimalTableViewCell.identifier, cellType:AnimalTableViewCell.self)) {row, element, cell in
            cell.name.text = element.gender
            if let url = URL(string: element.image_url) {
                cell.photo.loadImage(from: url)
            }
        }.disposed(by: disposebag)
    }
    
    func filterDataInjection() {
        viewModel.filterGender.bind { filterText in
            switch filterText {
            case "전체":
                self.viewModel.users.accept(self.viewModel.data)
            case "Male":
                self.viewModel.users.accept(self.viewModel.data.filter{ $0.gender == "Male" })
            case "Female":
                self.viewModel.users.accept(self.viewModel.data.filter{ $0.gender == "Female" })
            default:
                print("error")
            }
        }
    }
    
    func tableViewCellTapped() {
        tableView
            .rx
            .modelSelected(AnimalModel.self)
            .subscribe { data in
                print("\(data)")
                let detail = AnimalDetailView()
                detail.modalTransitionStyle = .crossDissolve
                detail.modalPresentationStyle = .overFullScreen
//                detail.name.onNext(data.name)
//                detail.imageURL.onNext(data.image_url)
                detail.detailInfo.accept(data)
                self.present(detail,animated:true)
            }.disposed(by: disposebag)
    }
    
    
    @objc func searchTapped() {
        print("Tapped")
        let v = FishViewController()
        v.modalPresentationStyle = .fullScreen
        present(FishViewController(), animated: true)
    }
    
    //MARK: Navigation 관련 세팅
    func naivationSetting() {
        if #available(iOS 16.0, *) {
            navigationItem.style = .navigator
        } else {
            // Fallback on earlier versions
        }
        navigationItem.title = "주민목록"
        
        //MARK: 이 속성을 사용하면 top area 설정가능
        navigationController?.navigationBar.isTranslucent = false
        //Set NavigationTitle Text & Color
        let searchImage = UIImage(systemName: "magnifyingglass")
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = searchBarButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    //MARK: Header 관련 세팅
    func headerSetting() {
        view.addSubview(header)
        header.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
        header.dropDown.selectionAction = {[weak self] (index: Int, item: String) in
            self?.header.mybutton.setTitle("성별:\(item)", for: .normal)
            self?.viewModel.filterGender.onNext(item)
        }
    }
    
    //MARK: TableView 관련 세팅
    func tableViewSetting() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        //tableView SafeArea
        self.tableView.insetsContentViewsToSafeArea = true
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
}


import SwiftUI
struct ViewController_preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
