//
//  TurnipView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/19.
//

import UIKit
import Then


final class TurnipView: UIView {
    
    private let sunLabel = UILabel().then {
        $0.text = "일요일"
        $0.textAlignment = .right
    }
    
    let sunPrice = UITextField().then {
        $0.keyboardType = .numberPad
        $0.placeholder = "구매가격"
    }
    
    private let monLabel = UILabel().then {
        $0.text = "월요일"
        $0.textAlignment = .right
    }
    
    let monAmPrice = UITextField().then {
        $0.placeholder = "월요일 오전"
        $0.keyboardType = .numberPad
    }
    
    let monPmPrice = UITextField().then {
        $0.placeholder = "월요일 오후"
        $0.keyboardType = .numberPad
    }
    
    private let tueLabel = UILabel().then {
        $0.text = "화요일"
        $0.textAlignment = .right
    }
    
    let tueAmPrice = UITextField().then {
        $0.placeholder = "화요일 오전"
        $0.keyboardType = .numberPad
    }
    
    let tuePmPrice = UITextField().then {
        $0.placeholder = "화요일 오후"
        $0.keyboardType = .numberPad
    }
    
    private let wedLabel = UILabel().then {
        $0.text = "수요일"
        $0.textAlignment = .right
    }
    
    let wedAmPrice = UITextField().then {
        $0.placeholder = "수요일 오전"
        $0.keyboardType = .numberPad
    }
    
    let wedPmPrice = UITextField().then {
        $0.placeholder = "수요일 오후"
        $0.keyboardType = .numberPad
    }
    
    private let thurLabel = UILabel().then {
        $0.text = "목요일"
        $0.textAlignment = .right
    }
    
    let thurAmPrice = UITextField().then {
        $0.placeholder = "목요일 오전"
        $0.keyboardType = .numberPad
    }
    
    let thurPmPrice = UITextField().then {
        $0.placeholder = "목요일 오후"
        $0.keyboardType = .numberPad
    }
    
    private let friLabel = UILabel().then {
        $0.text = "금요일"
        $0.textAlignment = .right
    }
    
    let friAmPrice = UITextField().then {
        $0.placeholder = "금요일 오전"
        $0.keyboardType = .numberPad
    }
    
    let friPmPrice = UITextField().then {
        $0.placeholder = "금요일 오후"
        $0.keyboardType = .numberPad
    }
    
    private let satLabel = UILabel().then {
        $0.text = "토요일"
        $0.textAlignment = .right
    }
    
    let satAmPrice = UITextField().then {
        $0.placeholder = "토요일 오전"
        $0.keyboardType = .numberPad
    }
    
    private let myBackgroundImageView = UIImageView().then {
        $0.transform = $0.transform.rotated(by: .pi/20)
        $0.image = UIImage(named: "memo2")!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TurnipView {
    func configureSubViews() {
        self.addSubViews(myBackgroundImageView,
                         sunLabel,
                         sunPrice,
                         monLabel,
                         monAmPrice,
                         monPmPrice,
                         tueLabel,
                         tueAmPrice,
                         tuePmPrice,
                         wedLabel,
                         wedAmPrice,
                         wedPmPrice,
                         thurLabel,
                         thurAmPrice,
                         thurPmPrice,
                         friLabel,
                         friAmPrice,
                         friPmPrice,
                         satLabel,
                         satAmPrice)
    }
    
    func configureUI() {
        myBackgroundImageView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        sunLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.left.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        sunPrice.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.left.equalTo(sunLabel.snp.right).offset(20)
            $0.width.equalTo(100)
        }
        
        monLabel.snp.makeConstraints {
            $0.top.equalTo(sunLabel.snp.top).inset(40)
            $0.left.right.equalTo(sunLabel)
            $0.width.equalTo(200)
        }
        
        monAmPrice.snp.makeConstraints {
            $0.top.equalTo(sunLabel.snp.top).inset(40)
            $0.left.right.equalTo(sunPrice)
        }
        
        monPmPrice.snp.makeConstraints {
            $0.top.equalTo(sunLabel.snp.top).inset(40)
            $0.left.equalTo(monAmPrice.snp.right).offset(20)
            $0.width.equalTo(monAmPrice)
        }
        
        tueLabel.snp.makeConstraints {
            $0.top.equalTo(monLabel.snp.top).inset(40)
            $0.left.right.equalTo(monLabel)
        }
        
        tueAmPrice.snp.makeConstraints {
            $0.top.equalTo(monLabel.snp.top).inset(40)
            $0.left.right.equalTo(monAmPrice)
        }
        
        tuePmPrice.snp.makeConstraints {
            $0.top.equalTo(monLabel.snp.top).inset(40)
            $0.left.right.equalTo(monPmPrice)
        }
        
        wedLabel.snp.makeConstraints {
            $0.top.equalTo(tueLabel.snp.top).inset(40)
            $0.left.right.equalTo(tueLabel)
        }
        
        wedAmPrice.snp.makeConstraints {
            $0.top.equalTo(tueLabel.snp.top).inset(40)
            $0.left.right.equalTo(tueAmPrice)
        }
        
        wedPmPrice.snp.makeConstraints {
            $0.top.equalTo(tueLabel.snp.top).inset(40)
            $0.left.right.equalTo(tuePmPrice)
        }
        
        thurLabel.snp.makeConstraints {
            $0.top.equalTo(wedLabel.snp.top).inset(40)
            $0.left.right.equalTo(wedLabel)
        }
        
        thurAmPrice.snp.makeConstraints {
            $0.top.equalTo(wedLabel.snp.top).inset(40)
            $0.left.right.equalTo(wedAmPrice)
        }
        
        thurPmPrice.snp.makeConstraints {
            $0.top.equalTo(wedLabel.snp.top).inset(40)
            $0.left.right.equalTo(wedPmPrice)
        }
        
        friLabel.snp.makeConstraints {
            $0.top.equalTo(thurLabel.snp.top).inset(40)
            $0.left.right.equalTo(thurLabel)
        }
        
        friAmPrice.snp.makeConstraints {
            $0.top.equalTo(thurLabel.snp.top).inset(40)
            $0.left.right.equalTo(thurAmPrice)
        }
        
        friPmPrice.snp.makeConstraints {
            $0.top.equalTo(thurLabel.snp.top).inset(40)
            $0.left.right.equalTo(thurPmPrice)
        }
        
        satLabel.snp.makeConstraints {
            $0.top.equalTo(friLabel.snp.top).inset(40)
            $0.left.right.equalTo(friLabel)
        }
        
        satAmPrice.snp.makeConstraints {
            $0.top.equalTo(friLabel.snp.top).inset(40)
            $0.left.right.equalTo(sunPrice)
        }   
    }
}

import SwiftUI
struct ViewController231_preview: PreviewProvider {
    static var previews: some View {
        TurnipViewController().toPreview()
    }
}
