//
//  BugViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/18.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class BugViewModel: ViewModel {
    var users: BehaviorRelay<[Bug]> = BehaviorRelay(value: [Bug]())
    private let provider = MoyaProvider<AnimalWikiAPI>()
    var users_copy: [Bug] = []
    var disposeBag = DisposeBag()
    
    struct Input {
        let allButtonTapped: ControlEvent<Void>
    }
    struct Output {
        let allButtonTappedResult: Observable<[Bug]>
        let items = BehaviorRelay<[Bug]>(value: [])
        let getData: Single<[Bug]>
    }
    
    
    func transform(input: Input) -> Output {
        
        let allButtonTappedResult = input.allButtonTapped
            .map { self.users.value != self.users_copy }
            .filter { $0 == true }
            .map { _ in self.users_copy }
        
        let aa = provider.rx.request(.getBugList)
            .map([Bug].self)

        
        return Output(allButtonTappedResult: allButtonTappedResult, getData: aa)
    }

}
