//
//  CustomHeaderView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/16.
//

import UIKit
import DropDown

class CustomHeaderView: UITableViewHeaderFooterView {
    static let identifier = "CustomHeaderView"
    
    
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
        stack.spacing = 10
        stack.layer.cornerRadius = 20
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
    
    let dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.dataSource = ["남자","여자"]
        return dropDown
    }()
    
    private var mybutton: UIButton = {
        let button = UIButton()
        button.setTitle("성별선택", for: .normal)
        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        return button
    }()
    
    @objc func openMenu() {
        print(#function)
        dropDown.show()
    }
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.insetsLayoutMarginsFromSafeArea = true
        setupHeaderView()
        vStackLayout()
        firstHStackLayout()
        secondHStackLayout()
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
        vStack.backgroundColor = #colorLiteral(red: 0.07395900041, green: 0.3695197701, blue: 0, alpha: 1)
        vStack.layer.cornerRadius = 20
        
        vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        vStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func firstHStackLayout() {
        firstHStackView.widthAnchor.constraint(equalToConstant: vStack.frame.width - 40).isActive = true
        firstHStackView.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.25).isActive = true
        firstHStackView.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 20).isActive = true
        firstHStackView.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: -20).isActive = true
        firstHStackView.topAnchor.constraint(equalTo: vStack.topAnchor, constant: 50).isActive = true
        
        firstHStackTextField.backgroundColor = .white
        firstHStackTextField.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.8).isActive = true
        
        firstHStackImage.backgroundColor = .clear
    }
    
    func secondHStackLayout() {
        secondHStackView.backgroundColor = #colorLiteral(red: 0.5036697984, green: 0.7757260203, blue: 0.3441850245, alpha: 1)
        secondHStackView.topAnchor.constraint(equalTo: firstHStackView.bottomAnchor, constant: 10).isActive = true
        secondHStackView.widthAnchor.constraint(equalToConstant: vStack.frame.width - 40).isActive = true
        secondHStackView.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.25).isActive = true
        secondHStackView.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 20).isActive = true
        secondHStackView.trailingAnchor.constraint(equalTo: vStack.trailingAnchor,constant: -20).isActive = true
    }
}

import SwiftUI
struct CustomHeaderView_preview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
