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

class CreatureViewController: UIViewController {
    
    typealias Item = CollectionViewCell
    typealias Header = CreatureCellHeader
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: CreatureViewController.createLayout())
    
    let disposeBag = DisposeBag()
    let viewModel = CreatureViewModel()
    
    let sections: [Int] = [10,10,5]
    var tagList: [String] = ["파이썬","자바","스위프트"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(Item.self, forCellWithReuseIdentifier: Item.identifier)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        //        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionViewLayout()
        navigationSetting()

        
    }
    
    func collectionViewLayout() {
        collectionView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            $0.right.equalToSuperview().inset(10)
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/5),
                    heightDimension: .fractionalHeight(1/5)),
                subitem: item,
                count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                          heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading)
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
                cell.imageView.kf.setImage(with: URL(string: data[indexPath.row].image_url))
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
            return headerView
        case 1:
            headerView.label.text = "물고기"
            return headerView
        case 2:
            headerView.label.text = "곤충"
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
            return UINavigationController(rootViewController: CreatureViewController())
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        typealias  UIViewControllerType = UIViewController
    }
}

