//
//  Constants.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/21/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

let URL_BASE = "https://api.itbook.store/1.0/"
let SEARCH_URL = URL_BASE + "search/"
let BOOKDETAILS_URL = URL_BASE + "books/"

typealias SearchResultResponseCompletion = (SearchResults?) -> Void
typealias BookDetailsResponseCompletion = (BookDetails?) -> Void

let BOOKCELLIDENTIFIER = "BookCellIdentifier"
let BOOK_DETAILS_SEGUE_IDENTIFIER = "BookDetails"

let KB : UInt64 = 1024

// MARK: Image Cache
let MEMORY_CAPACITY = 50
let PREFFERRED_MEMORY_USAGE_AFTER_PURGE = 30
let PAGE_SIZE = 10

let IMAGE_RESOURCE = "mybookshelf"
