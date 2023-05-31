//
//  CreatureViewController.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/05/31.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

class CreatureViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = CreatureViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Task { try await viewModel.getCreature() }
    }

}
