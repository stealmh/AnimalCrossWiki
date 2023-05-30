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
import Kingfisher

class AnimalDetailViewController: UIViewController {
    
    let dispose = DisposeBag()
    let detailInfo: BehaviorRelay<AnimalModel> = BehaviorRelay(value: AnimalModel(name: "뽀삐", image_url: "https://dodo.ac/np/images/9/94/Ribbot_NH.png", gender: "남자", species: "개구리", birthday_month: "May", birthday_day: "5"))
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

    private let animalPhoto = CustomImageView(image: UIImage(systemName: "person"))
    private let genderLabel = UILabel()
    private let speciesLabel = UILabel()
    private let birthday_month = UILabel()
    private let birthday_day = UILabel()
    
    let contentsStack: UIStackView = {
        let stack = UIStackView()
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
            .bind { _ in self.dismiss(animated: true) }
            .disposed(by: dispose)
        
        self.animalPhoto.kf.setImage(with: URL(string: detailInfo.value.image_url))
        
        detailInfo.asDriver()
            .drive(onNext: {data in
                self.animalName.text = data.name
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
        AnimalDetailViewController().toPreview()
    }
}
