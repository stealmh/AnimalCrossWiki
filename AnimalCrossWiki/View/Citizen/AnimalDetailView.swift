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
import SnapKit

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
    
    let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("닫기", for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.isOpaque = false
        
        addViewList()

        //MARK: Layout
        detailView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40)
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(view.frame.width - 80)
            $0.height.equalTo(400)
        }

        closeButton.snp.makeConstraints {
            $0.top.right.equalTo(detailView)
            $0.width.height.equalTo(40)
        }

        animalPhoto.snp.makeConstraints {
            $0.centerX.equalTo(detailView)
            $0.top.equalTo(detailView).inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }

        contentsStack.snp.makeConstraints {
            $0.centerX.equalTo(detailView)
            $0.top.equalTo(animalPhoto.snp.bottom).inset(10)
            $0.bottom.equalTo(detailView.snp.bottom).inset(10)
        }
        
        //MARK: Rx
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
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
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
    
    func addViewList() {
        detailView.addSubview(closeButton)
        detailView.addSubview(animalPhoto)
        
        contentsStack.addArrangedSubview(animalName)
        contentsStack.addArrangedSubview(genderLabel)
        contentsStack.addArrangedSubview(speciesLabel)
        contentsStack.addArrangedSubview(birthday_day)
        contentsStack.addArrangedSubview(birthday_month)
        detailView.addSubview(contentsStack)
        
        view.addSubview(detailView)
    }

}


import SwiftUI
struct AnimalDetail_preview: PreviewProvider {
    static var previews: some View {
        AnimalDetailView().toPreview()
    }
}
