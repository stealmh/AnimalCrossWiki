//
//  BugViewModel.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/04/18.
//

import Foundation
import RxSwift
import RxCocoa

class BugViewModel {

    var filterGender = BehaviorSubject(value:"")
    var users = BehaviorRelay(value: [Bug]())

    
    private let version: String = "1.5.0"
    let myKey = Bundle.main.apiKey
    let url: String = "https://api.nookipedia.com/nh/bugs"
    
    func getData() async throws{
        let url = URL(string: self.url)
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue(self.myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([Bug].self, from: data)
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
