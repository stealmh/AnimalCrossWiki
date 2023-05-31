//
//  CreatureViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/31.
//
// https://coding-idiot.tistory.com/7

import RxSwift
import RxCocoa

class CreatureViewModel {
    
    var disposeBag = DisposeBag()
    let parameter = ""
    
    var creatureList: [Creature] = []
    var fishList: [Fish] = []
    var bugList: [Bug] = []
    
    
    func getCreature() async throws{
        
        let url = URL(string: AddressConstants.url + parameter)
        let version: String = AddressConstants.version
        let myKey = Bundle.main.apiKey
        var request = URLRequest(url: url!)
        
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([Creature].self, from: data)
        creatureList = result
    }
    
    func getCreature<T: Decodable>(parameter: String, _ type: T.Type) async throws -> [T] {
        
        let url = URL(string: AddressConstants.url + parameter)
        let version: String = AddressConstants.version
        let myKey = Bundle.main.apiKey
        var request = URLRequest(url: url!)
        
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([T].self, from: data)
        return result
    }

}
