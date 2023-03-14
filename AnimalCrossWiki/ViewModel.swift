//
//  ViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import Foundation
import RxSwift

class ViewModel {
    var data: [AnimalModel] = []
    var users = BehaviorSubject(value: [AnimalModel]())
    
    private let version: String = "1.5.0"
    let myKey = "4a59aa18-04df-4cae-9a40-6b97b7a29216"
    let url: String = "https://api.nookipedia.com/villagers"
    
    func getData() async throws{
        let url = URL(string: self.url)
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue(self.myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([AnimalModel].self, from: data)
        print(result.count)
        self.data = result
        self.users.onNext(result)
    }
    
//    func urlToUIImage(url: String) -> UIImage? {
//        guard let url = URL(string: url) else {return nil}
//        guard let data = try? Data(contentsOf: url) else {return nil}
//        let image = UIImage(data: data)
//        return image
//    }
    
    func urlToUIImage(myURL: String) async throws -> UIImage? {
        guard let url = URL(string: myURL) else {return nil}
        let (data, _) = try await URLSession.shared.data(from: url)
        let image = UIImage(data: data)
        return image
    }
    
    
    func loadImageAsyncRx(url: String) -> Observable<UIImage> {
        return Observable.create { emitter in
            let task = Task {
                do {
                    guard let image = try await self.urlToUIImage(myURL: url) else {return}
                    emitter.onNext(image)
                } catch {
                    emitter.onError(error)
                }
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
