//
//  SearchResults.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/20/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import Foundation
// MARK: - SearchResults
struct SearchResults: Codable {
    let error, total, page: String
    let books: [Book]
}
