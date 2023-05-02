//
//  ViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import Foundation
import RxSwift
import RxCocoa


class ViewModel {
    var data: [AnimalModel] = []
    var filterGender = BehaviorSubject(value:"")
    var users = BehaviorRelay(value: [AnimalModel]())
    
    let myKey = Bundle.main.apiKey
    let version = AddressConstants.version
    let url: String = AddressConstants.url + "/villagers"
    
    func getData() async throws{
        let url = URL(string: self.url)
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue(self.myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([AnimalModel].self, from: data)
        print("== Count: \(result.count) ==")
        self.data = result
        self.users.accept(result)
    }
    
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

    func loadImage(_ url: String) -> Observable<UIImage?> {
        
        let cache = NSString(string: url)
        
        return Observable.create { emitter in
            if let cachedImage = ImageCacheManager.shared.object(forKey: cache) {
                print("yes")
                emitter.onNext(cachedImage)
                emitter.onCompleted()
            }
            
            let myUrl = URL(string: url)!
            let task = URLSession.shared.dataTask(with: myUrl) { data, response, error in
                guard let data else {
                    emitter.onError(error!)
                    return
                }
                let image = UIImage(data: data)
                ImageCacheManager.shared.setObject(image!, forKey: cache)
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

