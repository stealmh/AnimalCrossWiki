//
//  MyHeader.swift
//  CompoPractice
//
//  Created by 김민호 on 2023/05/31.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class CreatureCellHeader: UICollectionReusableView {
    static let identifier = "CreatureCellHeader"
    let disposeBag = DisposeBag()
    let label = UILabel()
    let button = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)

    }
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        label.text = "카테고리"
        label.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().inset(10)
        }
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
        }
        button.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.width.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


import SwiftUI
struct ContentView_Previews1: PreviewProvider {
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
