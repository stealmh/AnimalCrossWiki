//
//  AnimalWikiAPI.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/06/09.
//

import Foundation
import Moya

enum AnimalWikiAPI {
    case getBugList
//    case getCitizenList
//    case getFishList
}

extension AnimalWikiAPI: TargetType {
    var baseURL: URL {
        return URL(string: AddressConstants.url)!
    }
    
    var path: String {
        switch self {
        case .getBugList:
            return "nh/bugs"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBugList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getBugList:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getBugList:
            let header = [
                "X-API-KEY": Bundle.main.apiKey,
                "Accept-version": AddressConstants.version
            ]
            return header
        }
    }
    
    
}
