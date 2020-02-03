//
//  Book.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/20/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import Foundation
struct Book: Codable {
    let title, subtitle, isbn13, price: String
    let image: String
    let url: String
}
extension Book : Equatable {
    static func == (lhs:Book, rhs:Book)->Bool {
        return lhs.isbn13 == rhs.isbn13
    }
}
