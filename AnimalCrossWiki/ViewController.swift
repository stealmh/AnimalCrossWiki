//
//  ViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private let viewModel = ViewModel()
    let disposebag = DisposeBag()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.identifier)
        return tv
    }()
    
    lazy var tableViewHeader: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        return header
    }()
    //
//    lazy var headerHStack: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [genderLabel])
//        tableViewHeader.addSubview(stack)
//        stack.axis = .horizontal
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        stack.leadingAnchor.constraint(equalTo: tableViewHeader.leadingAnchor).isActive = true
//        stack.trailingAnchor.constraint(equalTo: tableViewHeader.trailingAnchor).isActive = true
//        stack.widthAnchor.constraint(equalToConstant: tableViewHeader.frame.width).isActive = true
//
//        stack.bottomAnchor.constraint(equalTo: tableViewHeader.bottomAnchor).isActive = true
//        stack.topAnchor.constraint(equalTo: tableViewHeader.topAnchor, constant: 40).isActive = true
////        stack.heightAnchor.constraint(equalToConstant: tableViewHeader.frame.height).isActive = true
//
//
//
//        return stack
//    }()
    
    lazy var genderLabel: UILabel = {
        let gender = UILabel()
        gender.text = "성별"
        gender.textColor = .white
        gender.backgroundColor = .red
        gender.translatesAutoresizingMaskIntoConstraints = false
//        gender.leadingAnchor.constraint(equalTo: headerHStack.leadingAnchor).isActive = true
//        gender.topAnchor.constraint(equalTo: headerHStack.topAnchor).isActive = true
//        gender.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return gender
    }()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        makeTableView()
        //Set NavigationTitle Text & Color
//        title = "주민 목록"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        Task {
            try await viewModel.getData()
            tableView.reloadData()
        }
    }
    
    func makeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        //tableView SafeArea
        self.tableView.insetsContentViewsToSafeArea = false
        self.tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        
        tableViewHeader.backgroundColor = .link
        tableViewHeader.layer.cornerRadius = 20
        tableView.tableHeaderView = tableViewHeader
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
        return 20.0
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerHStack
//    }
}
import SwiftUI
struct ViewController_preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
