//
//  ViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = ViewModel()
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
        
//            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
//            .map {URL(string: $0)}
//            .filter{ $0 != nil }
//            .map { $0! }
//            .map {try Data(contentsOf: $0)}
//            .map {UIImage(data: $0)}
//            .observe(on: MainScheduler.instance)
//            .bind(to: imageView.rx.image)
//            .disposed(by: disposable)
        
        let url = URL(string: viewModel.data[indexPath.row].image_url)!
        do {
            DispatchQueue.global().async {
                let data = try Data(contentsOf: url)
                let photo = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.photo.image = photo
                }
            }
        } catch {
            print("url Error")
        }
        cell.name.text = viewModel.data[indexPath.row].name
        return cell
    }
    
    
}
