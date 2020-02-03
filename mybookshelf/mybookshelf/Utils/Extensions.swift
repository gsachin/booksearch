//
//  UInt64MegabyteExtension.swift
//  mybookshelf
//
//  Created by Sachin Gupta on 1/26/20.
//  Copyright © 2020 Sachin Gupta. All rights reserved.
//

import Foundation
extension UInt64 {
    func megabytes() -> UInt64 {
        return self * KB * KB
    }
}
