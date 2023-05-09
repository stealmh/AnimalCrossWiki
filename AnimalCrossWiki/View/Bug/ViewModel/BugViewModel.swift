//
//  BugViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/18.
//

import Foundation
import RxSwift
import RxCocoa

class BugViewModel {
    var users: BehaviorRelay<[Bug]> = BehaviorRelay(value: [Bug]())
    private(set) var users_copy: [Bug] = []
    let parameter: String = "/nh/bugs"
    
    func getData() async throws{
        let version = AddressConstants.version
        let myKey = Bundle.main.apiKey
        let url = URL(string: AddressConstants.url + parameter)
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([Bug].self, from: data)
        users_copy = result
        self.users.accept(result)
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
