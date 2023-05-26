//
//  TurnipViewMdoel.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/18.
//

import Foundation

class TurnipViewModel {
    func getTurnipResult(parameter: String) async throws -> Turnip {
        let url = URL(string: "https://api.ac-turnip.com/data/?f=" + parameter)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(Turnip.self, from: data)
        print(result)
        return result
    }
}
