//
//  Image.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/26/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import Foundation
struct Image {
    let imageURL: String
    let imageName: String
    init(imageURL: String, imageName: String) {
        self.imageURL = imageURL
        self.imageName = imageName
    }
}
