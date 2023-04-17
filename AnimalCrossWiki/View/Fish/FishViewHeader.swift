//
//  FishViewHeader.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/13.
//

import UIKit
import RxCocoa
import RxSwift

class FishViewHeader: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    enum Constant {
      static let size: CGSize = .init(width: UIView.noIntrinsicMetric, height: 35)
    }
    override class func awakeFromNib() {
    }
}
