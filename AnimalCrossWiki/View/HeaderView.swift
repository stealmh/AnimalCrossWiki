//
//  HeaderView.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/17.
//

import UIKit

class HeaderView: UIView {
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var contatinerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    private func setViewConstraints() {
        widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        contatinerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        contatinerViewHeight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView){
        contatinerViewHeight.constant = scrollView.adjustedContentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.adjustedContentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.adjustedContentInset.top, scrollView.adjustedContentInset.top)
    }
    
}
