//
//  UIImageView+Extension.swift
//  AnimalCrossWiki
//
//  Created by 김민호 on 2023/05/02.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageUrl(_ url: String) {
        print(#function)
        DispatchQueue.global(qos: .background).async {

            /// cache할 객체의 key값을 string으로 생성
            let cachedKey = NSString(string: url)

            /// cache된 이미지가 존재하면 그 이미지를 사용 (API 호출안하는 형태)
            if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                DispatchQueue.main.async {
                    print("잇음")
                    self.image = cachedImage
                    return
                }
            }

            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { (data, result, error) in
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = UIImage()
                    }
                    return
                }

                DispatchQueue.main.async { [weak self] in
                    if let data = data, let image = UIImage(data: data) {

                        /// 캐싱
                        ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
    
    func setImage(with urlString: String) {
      ImageCache.default.retrieveImage(forKey: urlString, options: nil) { result in
        switch result {
        case .success(let value):
          if let image = value.image {
            //캐시가 존재하는 경우
            self.image = image
          } else {
            //캐시가 존재하지 않는 경우
            guard let url = URL(string: urlString) else { return }
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            self.kf.setImage(with: resource)
          }
        case .failure(let error):
          print(error)
        }
      }
    }

}
