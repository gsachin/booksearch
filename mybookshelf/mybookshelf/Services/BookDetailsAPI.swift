//
//  BookDetails.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/21/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
class BookDetailsAPI {
    func getBookDetailsResponse(ISBN:String, completion: @escaping BookDetailsResponseCompletion) {
        guard let url = URL(string: "\(BOOKDETAILS_URL)\(ISBN)") else {
            return
        }
        Alamofire.request(url).responseJSON { (response) in
            
            switch response.result {
            case .success( _):
                guard let data = response.data else { return completion(nil)}
                let jsonDecoder = JSONDecoder()
                do {
                    let searchResults = try jsonDecoder.decode(BookDetails.self, from: data)
                    completion(searchResults)
                } catch {
                    debugPrint(error.localizedDescription)
                    completion(nil)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
        }
    }
}


