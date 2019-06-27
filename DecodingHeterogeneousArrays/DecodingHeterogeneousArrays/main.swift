//
//  main.swift
//  DecodingHeterogeneousArrays
//
//  Created by Ben Scheirman on 5/28/19.
//  Copyright © 2019 Fickle Bits, LLC. All rights reserved.
//

import Foundation


protocol DecodableClassFamily : Decodable {
    associatedtype BaseType : Decodable
    static var discriminator: Discriminator { get }

    func getType() -> BaseType.Type
}

enum Discriminator : String, CodingKey {
    case type
}

enum PostClassFamily : String, DecodableClassFamily {

    typealias BaseType = Post

    case text
    case image

    static var discriminator: Discriminator { return .type }

    func getType() -> Post.Type {
        switch self {
        case .text: return TextPost.self
        case .image: return ImagePost.self
        }
    }
}

extension KeyedDecodingContainer {
    func decodeHeterogeneousArray<F : DecodableClassFamily>(family: F.Type, forKey key: K) throws -> [F.BaseType] {

        var container = try nestedUnkeyedContainer(forKey: key)
        var containerCopy = container
        var items: [F.BaseType] = []
        while !container.isAtEnd {

            let typeContainer = try container.nestedContainer(keyedBy: Discriminator.self)
            do {
                let family = try typeContainer.decode(F.self, forKey: F.discriminator)
                let type = family.getType()
                // decode type
                let item = try containerCopy.decode(type)
                items.append(item)
            } catch let e as DecodingError {
                switch e {
                case .dataCorrupted(let context):
                    if context.codingPath.last?.stringValue == F.discriminator.stringValue {
                        print("WARNING: Unhandled key: \(context.debugDescription)")
                        _ = try containerCopy.decode(F.BaseType.self)
                    } else {
                        throw e
                    }
                default: throw e
                }
            }
        }
        return items
    }
}

let feed = Feed()
feed.posts.append(TextPost(text: "Hi there"))
feed.posts.append(ImagePost(imageURL: URL(string: "https://placekitten.com/300/200")!))
feed.posts.append(VideoPost(videoURL: URL(string: "https://example.com/video.mp4")!))

let data = try JSONEncoder().encode(feed)
print(String(data: data, encoding: .utf8)!)


let parsedFeed = try JSONDecoder().decode(Feed.self, from: data)
for post in parsedFeed.posts {
    print(post)
}
