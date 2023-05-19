//
//  TurnipView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/19.
//

import UIKit

final class TurnipView: UIView {
    
    private let sunLabel: UILabel = {
        let v = UILabel()
        v.text = "일요일"
        v.textAlignment = .right
        return v
    }()
    private let sunPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "구매가격"
        return v
    }()
    
    private let monLabel: UILabel = {
        let v = UILabel()
        v.text = "월요일"
        v.textAlignment = .right
        return v
    }()
    private let monAmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "월요일 오전"
        return v
    }()
    private let monPmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "월요일 오후"
        return v
    }()
    
    private let tueLabel: UILabel = {
        let v = UILabel()
        v.text = "화요일"
        v.textAlignment = .right
        return v
    }()
    private let tueAmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "화요일 오전"
        return v
    }()
    private let tuePmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "화요일 오후"
        return v
    }()
    
    private let wedLabel: UILabel = {
        let v = UILabel()
        v.text = "수요일"
        v.textAlignment = .right
        return v
    }()
    private let wedAmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "수요일 오전"
        return v
    }()
    private let wedPmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "수요일 오후"
        return v
    }()
    
    private let thurLabel: UILabel = {
        let v = UILabel()
        v.text = "목요일"
        v.textAlignment = .right
        return v
    }()
    private let thurAmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "목요일 오전"
        return v
    }()
    private let thurPmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "목요일 오후"
        return v
    }()
    
    private let friLabel: UILabel = {
        let v = UILabel()
        v.text = "금요일"
        v.textAlignment = .right
        return v
    }()
    private let friAmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "금요일 오전"
        return v
    }()
    private let friPmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "금요일 오후"
        return v
    }()
    
    private let satLabel: UILabel = {
        let v = UILabel()
        v.text = "토요일"
        v.textAlignment = .right
        return v
    }()
    private let satAmPrice: UITextField = {
        let v = UITextField()
        v.placeholder = "토요일 오전"
        return v
    }()
    
    private let myBackgroundImageView: UIImageView = {
        let v = UIImageView()
//        v.layer.borderColor = CGColor(red: 50, green: 0, blue: 0, alpha: 1)
//        v.layer.borderWidth = 10
        v.transform = v.transform.rotated(by: .pi/20)
        
                v.layer.borderColor = CGColor(red: 50, green: 0, blue: 0, alpha: 1)
                v.layer.borderWidth = 3
//                v.transform = v.transform.rotated(by: .pi/20)
        v.image = UIImage(named: "memo2")!
        return v
    }()
    
    
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
        self.addSubview(myBackgroundImageView)
        self.addSubview(sunLabel)
        self.addSubview(sunPrice)
        self.addSubview(monLabel)
        self.addSubview(monAmPrice)
        self.addSubview(monPmPrice)
        self.addSubview(tueLabel)
        self.addSubview(tueAmPrice)
        self.addSubview(tuePmPrice)
        self.addSubview(wedLabel)
        self.addSubview(wedAmPrice)
        self.addSubview(wedPmPrice)
        self.addSubview(thurLabel)
        self.addSubview(thurAmPrice)
        self.addSubview(thurPmPrice)
        self.addSubview(friLabel)
        self.addSubview(friAmPrice)
        self.addSubview(friPmPrice)
        self.addSubview(satLabel)
        self.addSubview(satAmPrice)
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
