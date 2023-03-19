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

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    let disposebag = DisposeBag()
    let header: CustomHeaderView = {
        let hd = CustomHeaderView()
        return hd
    }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        makeHeader()
        naivationSetting()
        makeTableView()
        
        Task {
            try await viewModel.getData()
            tableView.reloadData()
        }
    }
    
    @objc func searchTapped() {
        print("Tapped")
    }
    
    //MARK: Navigation 관련 세팅
    func naivationSetting() {
        navigationItem.style = .navigator
        navigationItem.title = "주민목록"
        
        //MARK: 이 속성을 사용하면 top area 설정가능
        navigationController?.navigationBar.isTranslucent = false
        //Set NavigationTitle Text & Color
        let searchImage = UIImage(systemName: "magnifyingglass")
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = searchBarButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    //MARK: Header
    func makeHeader() {
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    //MARK: TableView
    func makeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimalTableViewCell.identifier, for: indexPath) as! AnimalTableViewCell
        
        if let url = URL(string: viewModel.data[indexPath.row].image_url) {
            cell.photo.loadImage(from: url)
        }
        cell.name.text = viewModel.data[indexPath.row].name
        return cell
    }
    // Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as? CustomHeaderView else {return UIView()}
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = AnimalDetailView()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}


import SwiftUI
struct ViewController_preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
