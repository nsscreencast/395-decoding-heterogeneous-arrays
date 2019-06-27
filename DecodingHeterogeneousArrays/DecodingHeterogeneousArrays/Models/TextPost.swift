//
//  TextPost.swift
//  DecodingHeterogeneousArrays
//
//  Created by Ben Scheirman on 5/28/19.
//  Copyright © 2019 Fickle Bits, LLC. All rights reserved.
//

import Foundation

class TextPost : Post {
    var text: String

    init(text: String) {
        self.text = text
        super.init(type: "text")
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        try super.init(from: decoder)
    }

    enum CodingKeys : String, CodingKey {
        case text
    }

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
    }

    override var description: String {
        return "TextPost: \(text)"
    }
}
