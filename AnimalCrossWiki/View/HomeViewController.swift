//
//  HomeViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/15.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 16.0, *) {
            navigationItem.style = .navigator
        } else {
            // Fallback on earlier versions
        }
        navigationItem.title = "Home"
        collectionView?.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }



}
