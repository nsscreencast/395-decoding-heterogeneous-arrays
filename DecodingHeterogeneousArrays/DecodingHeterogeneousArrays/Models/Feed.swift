//
//  Feed.swift
//  DecodingHeterogeneousArrays
//
//  Created by Ben Scheirman on 5/28/19.
//  Copyright © 2019 Fickle Bits, LLC. All rights reserved.
//

import Foundation

class Feed : Codable {
    var posts: [Post] = []

    init() {
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posts = try container.decodeHeterogeneousArray(family: PostClassFamily.self, forKey: .posts)
    }
}
