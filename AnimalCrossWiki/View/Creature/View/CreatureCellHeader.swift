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

class CreatureCellHeader: UICollectionReusableView {
    static let identifier = "CreatureCellHeader"
    let disposeBag = DisposeBag()
    let label = UILabel()
    let button = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .black
    }
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        label.text = "카테고리"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
