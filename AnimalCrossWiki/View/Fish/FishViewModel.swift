//
//  FishViewModel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/21.
//
import RxSwift
import RxCocoa

final class FishViewModel {
    let parameter = "/nh/fish"
    let myData = BehaviorRelay<[Fish]>(value: [])
    
    func getFish() async throws {
        print(#function)
        let url = URL(string: AddressConstants.url + parameter)
        let version: String = AddressConstants.version
        let myKey = Bundle.main.apiKey
        var request = URLRequest(url: url!)
        
        request.setValue(myKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue(version, forHTTPHeaderField: "Accept-version")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode([Fish].self, from: data)

        myData.accept(result)
    }
    
    func filterFish() {
        
        var fish1 = myData.value
        fish1.sort { $0.number < $1.number }
        var fish = fish1
        
        fish.indices.forEach { idx in
            
            let fishCase = fish[idx].location
            switch fishCase {
            case FishCase.Pond.rawValue:
                fish[idx].location = "연못"
            case FishCase.River.rawValue:
                fish[idx].location = "강"
            case FishCase.Sea.rawValue:
                fish[idx].location = "바다"
            case FishCase.RiverClifftop.rawValue:
                fish[idx].location = "강(절벽위)"
            case FishCase.RiverMouth.rawValue:
                fish[idx].location = "강(하구)"
            case FishCase.Pier.rawValue:
                fish[idx].location = "부두"
            case FishCase.SeaRain.rawValue:
                fish[idx].location = "바다(비)"
            default:
                break
            }
        }
        myData.accept(fish)
    }

    
}
