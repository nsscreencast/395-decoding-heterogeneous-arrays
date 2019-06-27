//
//  ImagePost.swift
//  DecodingHeterogeneousArrays
//
//  Created by Ben Scheirman on 5/28/19.
//  Copyright © 2019 Fickle Bits, LLC. All rights reserved.
//

import Foundation

class ImagePost : Post {
    var imageURL: URL

    init(imageURL: URL) {
        self.imageURL = imageURL
        super.init(type: "image")
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        try super.init(from: decoder)
    }

    enum CodingKeys : String, CodingKey {
        case imageURL
    }

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageURL, forKey: .imageURL)
    }

    override var description: String {
        return "ImagePost: \(imageURL)"
    }
}
