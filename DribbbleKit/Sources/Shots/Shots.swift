//
//  Shots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct Shot {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public static func decode(_ decoder: Decoder) throws -> Shot.Identifier {
            return try self.init(integerLiteral: Int.decode(decoder))
        }
    }
}

extension Int {
    public init(_ shotId: Shot.Identifier) {
        self = shotId.value
    }
}

// MARK: - ShotData
public protocol ShotData: Decodable {
    init(
        id: Shot.Identifier,
        title: String,
        description: String,
        width: Int,
        height: Int,
        images: [String: URL],
        viewCount: Int
    ) throws
}

extension ShotData {
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            title: decoder.decode(forKeyPath: "title"),
            description: decoder.decode(forKeyPath: "description"),
            width: decoder.decode(forKeyPath: "width"),
            height: decoder.decode(forKeyPath: "height"),
            images: decoder.decode(forKeyPath: "images", skipInvalidElements: true, Transformer.url),
            viewCount: decoder.decode(forKeyPath: "view_count"))
    }
}
