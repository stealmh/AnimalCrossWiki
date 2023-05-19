//
//  TurnipResultViewController.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TurnipResultViewController: UIViewController {
    
    
    private let preview: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    private let disposeBag = DisposeBag()
    let detailInfo = BehaviorRelay(value: Turnip(minMaxPattern: [], avgPattern: [], minWeekValue: 0, preview: ""))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(preview)
        view.backgroundColor = UIColor(named: "turnip")
        preview.layer.borderColor = CGColor(red: 30, green: 0, blue: 0, alpha: 1)
        preview.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(10)
            $0.height.equalToSuperview().dividedBy(2)
        }
        
        loadImage(detailInfo.value.preview)
            .map { $0! }
            .bind(to: self.preview.rx.image)
            .disposed(by: disposeBag)

    }
    
    func loadImage(_ url: String) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let myUrl = URL(string: url)!
            let task = URLSession.shared.dataTask(with: myUrl) { data, response, error in
                guard let data else {
                    emitter.onError(error!)
                    return
                }
                let image = UIImage(data: data)
                emitter.onNext(image)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
