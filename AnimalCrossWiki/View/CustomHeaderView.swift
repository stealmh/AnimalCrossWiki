//
//  CustomHeaderView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/16.
//

import UIKit
import DropDown
import RxCocoa
import RxSwift

class CustomHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CustomHeaderView"
    var disposeBag = DisposeBag()
    
    //HStack들을 묶은 VStack
    private var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
//        stack.distribution = .fillProportionally
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // 검색창 등등이 들어가는 첫번째 HStack
    private var firstHStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    // 필터링하는 셀이 보여지는 두번째 HStack
    private var secondHStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private var firstHStackTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var firstHStackImage: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var name: UILabel = {
        let label = UILabel()
        label.text = "hello!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var name2: UILabel = {
        let label = UILabel()
        label.text = "hello!2"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dropDown = DropDown()
    
    lazy var mybutton: BaseButton = {
        let button = BaseButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setImage(UIImage(systemName: "person"), for: .normal)
        return button
    }()
    
    
    @objc func openMenu() {
        print(#function)
        dropDown.show()
    }

    override init(reuseIdentifier: String?) {
        print("생성")
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.insetsLayoutMarginsFromSafeArea = true
        setupHeaderView()
        vStackLayout()
        firstHStackLayout()
        secondHStackLayout()
        dropDown.dataSource = ["전체","Male","Female"]
        
        mybutton.setTitle("성별:전체", for: .normal)
        dropDown.anchorView = mybutton
        
        mybutton.rx.tap.bind {
            self.dropDown.show()
            print("tapped")
        }.disposed(by: disposeBag)
//        dropDown.selectionAction = {[weak self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self?.mybutton.setTitle("성별:\(item)", for: .normal)
//        }
        
    }
    deinit {
        print("사라짐")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeaderView() {
        //FirstHStack addView
        firstHStackView.addArrangedSubview(firstHStackTextField)
        firstHStackView.addArrangedSubview(firstHStackImage)
        
        //SecondHStack addView
        secondHStackView.addArrangedSubview(name)
        secondHStackView.addArrangedSubview(name2)
        secondHStackView.addArrangedSubview(mybutton)
        
        //VStack addStack
        vStack.addSubview(firstHStackView)
        vStack.addSubview(secondHStackView)
        
        //finally
        contentView.addSubview(vStack)
    }
    
    func vStackLayout() {
        vStack.backgroundColor = .red
        
        vStack.clipsToBounds = true
        vStack.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        vStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    func firstHStackLayout() {
        firstHStackView.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.25).isActive = true
        firstHStackView.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 20).isActive = true
        firstHStackView.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -20).isActive = true
        firstHStackView.topAnchor.constraint(equalTo: vStack.topAnchor, constant: 10).isActive = true
        
        firstHStackTextField.backgroundColor = .white
        firstHStackTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.8).isActive = true
        
        firstHStackImage.backgroundColor = .clear
        firstHStackImage.tintColor = .white
    }
    
    func secondHStackLayout() {
        secondHStackView.backgroundColor = #colorLiteral(red: 0.5036697984, green: 0.7757260203, blue: 0.3441850245, alpha: 1)
        
        secondHStackView.topAnchor.constraint(equalTo: firstHStackView.bottomAnchor, constant: 10).isActive = true
        secondHStackView.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.25).isActive = true
        secondHStackView.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 20).isActive = true
        secondHStackView.trailingAnchor.constraint(equalTo: vStack.trailingAnchor,constant: -20).isActive = true
        
//        mybutton.widthAnchor.constraint(equalTo: secondHStackView.widthAnchor, multiplier: 0.3).isActive = true
//        mybutton.heightAnchor.constraint(equalTo: secondHStackView.heightAnchor).isActive = true
//        mybutton.backgroundColor = .red
    }
}

import SwiftUI
struct CustomHeaderView_preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}

class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)

        /// 모든 방향에 20만큼 터치 영역 증가
        /// dx: x축이 dx만큼 증가 (음수여야 증가)
        let touchArea = bounds.insetBy(dx: -20, dy: -20)
        return touchArea.contains(point)
    }

    func configure() {}
    func bind() {}
}
