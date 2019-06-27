//
//  VideoPost.swift
//  DecodingHeterogeneousArrays
//
//  Created by Ben Scheirman on 5/28/19.
//  Copyright © 2019 Fickle Bits, LLC. All rights reserved.
//

import Foundation

class VideoPost : Post {
    var videoURL: URL

    init(videoURL: URL) {
        self.videoURL = videoURL
        super.init(type: "video")
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        videoURL = try container.decode(URL.self, forKey: .videoURL)
        try super.init(from: decoder)
    }

    enum CodingKeys : String, CodingKey {
        case videoURL
    }

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(videoURL, forKey: .videoURL)
    }

    override var description: String {
        return "VideoPost: \(videoURL)"
    }
}
