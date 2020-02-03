//
//  BookImageAPI.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/26/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
class BookImageAPI {
        func fetchImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
    
            return Alamofire.request(url, method: .get).responseImage { response in
                guard let image = response.result.value else { return }
                completion(image)
                self.cache(image, for: url)
            }
        }
    
    
    
       
}
