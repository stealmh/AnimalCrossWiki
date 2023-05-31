//
//  BaseViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/31.
//

import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
