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
    var isPaginating = false
    var start = 0
    var end = 14
    // 482 - 488
    var data: [AnimalModel] = []
    var filterGender = BehaviorSubject(value:"")
    var users = BehaviorRelay(value: [AnimalModel]())
    let parameter = "/villagers"
    
    func getData() async throws{
        let url = URL(string: AddressConstants.url + parameter)
        let myKey = Bundle.main.apiKey
        let version = AddressConstants.version
        
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([AnimalModel].self, from: data)
        print("== Count: \(result.count) ==")
        let a = Array(result[0...30])
        self.data = result
        self.users.accept(a)
    }
    
    func getData1() async throws{
        let url = URL(string: AddressConstants.url + parameter)
        let myKey = Bundle.main.apiKey
        let version = AddressConstants.version
        
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([AnimalModel].self, from: data)
        print("== Count: \(result.count) ==")
        self.data = result
    }
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[AnimalModel], Error>) -> Void) {
        
        if pagination { isPaginating = true }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let data = Array(self.data[0...14])
            print(data.count)
            
            if self.start == 480 {
                let newData = Array(self.data[480...])
                completion(.success(pagination ? newData : data))
                self.isPaginating = true
                return
            } else {
                let newData = Array(self.data[(self.start)...(self.end)])
                completion(.success(pagination ? newData : data))
            }
            
            if pagination {
                self.isPaginating = false
            }
        })
        self.start += 15
        self.end += 15
        
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
                print(cachedImage)
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

