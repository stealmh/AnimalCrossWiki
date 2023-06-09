//
//  ViewController.swift
//  CompoPractice
//
//  Created by KindSoft on 2023/05/11.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Kingfisher


protocol CreatureViewControllerDelegate: AnyObject {
    func didTapCreatureCell(_ viewController: CreatureViewController)
    func didTapFishCell(_ viewController: CreatureViewController)
    func didTapBugCell(_ viewController: CreatureViewController)
}

class CreatureViewController: UIViewController {
    
    typealias Item = CollectionViewCell
    typealias Header = CreatureCellHeader
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: CreatureViewController.createLayout())
    
    let disposeBag = DisposeBag()
    let viewModel: CreatureViewModel
    
    let sections: [Int] = [10,10,5]
    var tagList: [String] = ["파이썬","자바","스위프트"]
    
    weak var delegate: CreatureViewControllerDelegate?
    
    init(viewModel: CreatureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(Item.self, forCellWithReuseIdentifier: Item.identifier)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        //        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionViewLayout()
        navigationSetting()
        
        
        
    }
    
    func collectionViewLayout() {
        collectionView.snp.makeConstraints {
//            $0.width.equalToSuperview()
//            $0.height.equalToSuperview()
            $0.left.right.equalToSuperview().inset(10)
            
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            
            
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func didLogoTapped() {}
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/5),
                    heightDimension: .fractionalHeight(1/5)),
                subitem: item,
                count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topTrailing)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = .groupPaging
            
            
            // Return
            return section
            
        }
    }
}

extension CreatureViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let divider = indexPath.section
        switch divider {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Item.identifier, for: indexPath) as! Item
            
            Task { let data = try await viewModel.getCreature(parameter: AddressConstants.creatureParameter,
                                                              Creature.self)
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with: URL(string: data[indexPath.row].image_url))
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Item.identifier, for: indexPath) as! Item
            Task { let data = try await viewModel.getCreature(parameter: AddressConstants.fishParameter,
                                                              Fish.self)
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with: URL(string: data[indexPath.row].image_url))
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Item.identifier, for: indexPath) as! Item
            Task { let data = try await viewModel.getCreature(parameter: AddressConstants.bugParameter,
                                                              Bug.self)
                cell.imageView.kf.indicatorType = .activity
//                cell.imageView.kf.setImage(with: URL(string: data[indexPath.row].image_url))
                let url = data[indexPath.row].image_url
//                cell.imageView.setImage(with: url)
                cell.imageView.setImageUrl(url)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension CreatureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let divider = indexPath.section
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as! Header
        
        switch divider {
        case 0:
            headerView.label.text = "해산물"
            headerView.button.rx.tap
                .subscribe(onNext: {_ in
                    self.delegate?.didTapCreatureCell(self)
                }).disposed(by: headerView.disposeBag)
            return headerView
        case 1:
            headerView.label.text = "물고기"
            headerView.button.rx.tap
                .subscribe(onNext: {_ in
                    self.delegate?.didTapFishCell(self)
                }).disposed(by: headerView.disposeBag)
            return headerView
        case 2:
            headerView.label.text = "곤충"
            headerView.button.rx.tap
                .subscribe(onNext: {_ in
                    self.delegate?.didTapBugCell(self)
                }).disposed(by: headerView.disposeBag)
            return headerView
        default:
            return headerView
            
        }
    }
}

extension CreatureViewController {
    func navigationSetting() {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(didLogoTapped), imageName: "logo")
    }
}

import SwiftUI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return UINavigationController(rootViewController: CreatureViewController(viewModel: CreatureViewModel()))
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        typealias  UIViewControllerType = UIViewController
    }
}

