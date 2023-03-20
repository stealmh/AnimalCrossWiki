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
    let detailInfo: BehaviorRelay<AnimalModel> = BehaviorRelay(value: AnimalModel(name: "뽀삐", image_url: "https://dodo.ac/np/images/9/94/Ribbot_NH.png", gender: "남자", species: "개구리", birthday_month: "May", birthday_day: "5"))
    let name: BehaviorSubject<String> = BehaviorSubject(value: "")
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
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let birthday_month: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let birthday_day: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
//    var name: String #Done
//    var image_url: String #Done
//    var gender: String #Done
//    var species: String
//    var birthday_month: String
//    var birthday_day: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.isOpaque = false
        
        myAddView()
        makeUIView()
        makeCloseButtonLayout()
        makePhotoLayout()
        contentsStackLayout()
        
        closeButton.rx.tap.bind { _ in
            self.dismiss(animated: true)
        }.disposed(by: dispose)
        
        view.rx.tapGesture()
            .when(.recognized)
//            .skip(1)
            .bind { _ in self.dismiss(animated: true) }
            .disposed(by: dispose)
        
//        name.bind(to: animalName.rx.text).disposed(by: dispose)
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
        
        detailInfo
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {data in
                self.animalName.text = data.name
                self.imageURL.onNext(data.image_url)
                self.genderLabel.text = data.gender
                self.speciesLabel.text = data.species
                self.birthday_day.text = data.birthday_day
                self.birthday_month.text = data.birthday_month
            }).disposed(by: dispose)
    }
    
    func myAddView() {
        myView.addSubview(closeButton)
        myView.addSubview(animalPhoto)
        
        contentsStack.addArrangedSubview(animalName)
        contentsStack.addArrangedSubview(genderLabel)
        contentsStack.addArrangedSubview(speciesLabel)
        contentsStack.addArrangedSubview(birthday_day)
        contentsStack.addArrangedSubview(birthday_month)
        myView.addSubview(contentsStack)
        
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
    
    func contentsStackLayout() {
//        contentsStack.backgroundColor = .red
        contentsStack.centerXAnchor.constraint(equalTo: myView.centerXAnchor).isActive = true
        contentsStack.topAnchor.constraint(equalTo: animalPhoto.bottomAnchor, constant: 10).isActive = true
//        contentsStack.leadingAnchor.constraint(equalTo: animalPhoto.leadingAnchor, constant: 0).isActive = true
//        contentsStack.trailingAnchor.constraint(equalTo: animalPhoto.trailingAnchor, constant: 0).isActive = true
        contentsStack.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -10).isActive = true
        
    }
//    var name: String
//    var image_url: String
//    var gender: String
//    var species: String
//    var birthday_month: String
//    var birthday_day: String

}

import SwiftUI
struct AnimalDetail_preview: PreviewProvider {
    static var previews: some View {
        AnimalDetailView().toPreview()
    }
}
