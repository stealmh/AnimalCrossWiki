//
//  AnimalDetailView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class AnimalDetailView: UIViewController {
    
    let dispose = DisposeBag()
    var name: BehaviorSubject<String> = BehaviorSubject(value: "")
    var imageURL: BehaviorSubject<String> = BehaviorSubject(value: "")
    let activity: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView()
        act.isHidden = false
        return act
    }()
    
    let animalName: UILabel = {
        let label = UILabel()
        label.text = "뽀삐"
        return label
    }()
    
    let myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let animalPhoto: CustomImageView = {
        let photo = CustomImageView()
        photo.image = UIImage(systemName: "person")
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.isOpaque = false
        
        myAddView()
        makeUIView()
        makeCloseButtonLayout()
        makePhotoLayout()
        
        closeButton.rx.tap.bind { _ in
            self.dismiss(animated: true)
        }.disposed(by: dispose)
        
        view.rx.tapGesture()
            .when(.recognized)
//            .skip(1)
            .bind { _ in self.dismiss(animated: true) }
            .disposed(by: dispose)
        
        name.bind(to: animalName.rx.text).disposed(by: dispose)
        imageURL
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .map {URL(string:$0)}
            .filter{$0 != nil}
            .map {$0!}
            .map {try Data(contentsOf: $0)}
            .map{UIImage(data: $0)}
            .observe(on: MainScheduler.instance)
            .bind(to: animalPhoto.rx.image)
            .disposed(by: dispose)

    }
    
    func myAddView() {
        myView.addSubview(closeButton)
        myView.addSubview(animalPhoto)
        view.addSubview(myView)
    }
    
    func makeUIView() {
        myView.backgroundColor = .white
        myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        myView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        myView.widthAnchor.constraint(equalToConstant: view.frame.width - 80).isActive = true
        myView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func makeCloseButtonLayout() {
        closeButton.backgroundColor = .blue
        closeButton.topAnchor.constraint(equalTo: myView.topAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func makePhotoLayout() {
        animalPhoto.centerXAnchor.constraint(equalTo: myView.centerXAnchor).isActive = true
        animalPhoto.topAnchor.constraint(equalTo: myView.topAnchor, constant: 10).isActive = true
        animalPhoto.widthAnchor.constraint(equalToConstant: 100).isActive = true
        animalPhoto.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }

}
