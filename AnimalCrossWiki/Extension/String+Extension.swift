//
//  String+util.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/02.
//

import UIKit

extension String {
    func toUIImage(completion: @escaping (Result<UIImage,Error>)->Void) {
        if let url = URL(string: self) {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data,
                      let newImage = UIImage(data: data) else {return}
                DispatchQueue.main.async {
                    completion(.success(newImage))
                }
            }
            task.resume()
        }
    }
    
    var isValid: Bool {
        let regex = "[0-9]{2,3}"
        let p = NSPredicate(format: "SELF MATCHES %@", regex)
        return p.evaluate(with: self)
    }
}
