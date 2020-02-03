//
//  ImageManager.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/26/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageManager {
    
    static let shared = ImageManager()
    private init()
    {
    }
    private var path: String {
        return Bundle.main.path(forResource: IMAGE_RESOURCE, ofType: "plist")!
    }
    
    lazy var Images: [Image] = {
        var Images = [Image]()
        guard let data = NSArray(contentsOfFile: self.path) as? [[String: Any]] else { return Images }
        for info in data {
            if let imageUrl = info["imageURL"] as? String , let imageName = info["imageName"] as? String{
                let photo = Image(imageURL: imageUrl ,imageName: imageName)
                Images.append(photo)
            }
        }
        return Images
    }()
    
    let imagesCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(MEMORY_CAPACITY).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(PREFFERRED_MEMORY_USAGE_AFTER_PURGE).megabytes()
    )
    func fetchImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
            self.cache(image, for: url)
        }
    }
    func cache(_ image: UIImage, for url: String) {
        
        imagesCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> UIImage? {
        return imagesCache.image(withIdentifier: url)
    }
    
}

