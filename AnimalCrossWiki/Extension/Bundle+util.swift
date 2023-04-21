//
//  Bundle+util.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/04/21.
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
