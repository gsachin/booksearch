//
//  BookDetails.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/21/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//
/*{
    "error":"0",
    "title":"Beginning iOS Programming",
    "subtitle":"Building and Deploying iOS Applications",
    "authors":"Nick Harris",
    "publisher":"Wrox",
    "language":"English",
    "isbn10":"1118841476",
    "isbn13":"9781118841471",
    "pages":"336",
    "year":"2014",
    "rating":"3",
    "desc":"iOS 7 is a major shift in the look and feel of apps - the first major sea change since the iPhone was first introduced. For apps to blend in with the new UI, each needs a complete redesign. Beginning iOS Programming: Building and Deploying iOS Applications starts at the beginning - including an intr...",
    "price":"$6.35",
    "image":"https://itbook.store/img/books/9781118841471.png",
    "url":"https://itbook.store/books/9781118841471"
    
}*/
import Foundation
struct BookDetails: Codable {
    let error, title, subtitle, authors: String
    let publisher, language, isbn10, isbn13: String
    let pages, year, rating, desc: String
    let price: String
    let image: String
    let url: String
}
