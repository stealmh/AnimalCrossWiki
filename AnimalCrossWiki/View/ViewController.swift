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
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.register(AnimalTableViewCell.self, forCellReuseIdentifier: AnimalTableViewCell.identifier)
        
        tv.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)
        return tv
    }()
    
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
        return 150.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as? CustomHeaderView else {return UIView()}
        return headerView
    }
}
import SwiftUI
struct ViewController_preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
