//
//  ImageCacheManager.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/02.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
