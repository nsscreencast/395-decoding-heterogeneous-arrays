//
//  Post.swift
//  DecodingHeterogeneousArrays
//
//  Created by Ben Scheirman on 5/28/19.
//  Copyright © 2019 Fickle Bits, LLC. All rights reserved.
//

import Foundation

class Post : Codable, CustomStringConvertible {
    var id: String
    var date = Date()
    var type: String

    init(type: String) {
        id = UUID().uuidString
        self.type = type
    }

    var description: String {
        return "Post ???"
    }
}
