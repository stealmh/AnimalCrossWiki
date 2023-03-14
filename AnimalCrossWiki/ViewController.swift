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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .blue
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        Task {
            try await viewModel.getData()
            tableView.reloadData()
        }
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
//        
//        viewModel.loadImageAsyncRx(url: viewModel.data[indexPath.row].image_url)
//            .observe(on: MainScheduler.instance)
//            .subscribe{ data in
//                cell.photo.image = data
//            }.disposed(by: disposebag)
        
        cell.name.text = viewModel.data[indexPath.row].name
        return cell
    }
    
    
}
