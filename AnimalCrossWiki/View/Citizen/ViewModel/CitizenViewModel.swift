//
//  ViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/03/14.
//

import Foundation
import RxSwift
import RxCocoa


class CitizenViewModel {
    var isPaginating = false
    var start = 0
    var end = 14
    // 482 - 488
    var data: [AnimalModel] = []
    var forLogoTouchData: [AnimalModel] = []
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

}

