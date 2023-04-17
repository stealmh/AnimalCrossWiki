//
//  AnimalCrossWiki+Bundle.swift
//  AnimalCrossWiki
//
//  Created by KindSoft on 2023/04/17.
//

import Foundation


extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "Info", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else {return ""}
        guard let key = resource["API_KEY"] as? String else {fatalError("== Info.plist의 API_KEY를 입력하세요 ==")}
        return key
    }
}
