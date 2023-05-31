//
//  CreatureViewModel.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/05/31.
//

import RxSwift
import RxCocoa

final class CreatureViewModel {
    let parameter = "/nh/sea"
    
    func getCreature() async throws {
        
        let url = URL(string: AddressConstants.url + parameter)
        let version: String = AddressConstants.version
        let myKey = Bundle.main.apiKey
        var request = URLRequest(url: url!)
        
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
//        print(String(data: data, encoding: .utf8))
        let result = try JSONDecoder().decode([Creature].self, from: data)
        print(result.first)
        
    }
}
