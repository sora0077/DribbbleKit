//
//  Shots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Himotoki

public struct Shot {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public static func decode(_ e: Extractor) throws -> Shot.Identifier {
            return try self.init(integerLiteral: Int.decode(e))
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
        images: [String: URL?],
        viewCount: Int
    ) throws
}

extension ShotData {
    public static func decode(_ e: Extractor) throws -> Self {
        return try self.init(
            id: e.value("id"),
            title: e.value("title"),
            description: e.value("description"),
            width: e.value("width"),
            height: e.value("height"),
            images: e.dictionary("images", Transformer.url),
            viewCount: e.value("view_count"))
    }
}
