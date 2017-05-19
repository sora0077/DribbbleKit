//
//  Comments.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct Comment {
    public struct Identifier: Decodable, Hashable, ExpressibleByIntegerLiteral {
        let value: Int
        public var hashValue: Int { return value.hashValue }

        public init(integerLiteral value: Int) {
            self.value = value
        }

        public init(_ value: Int) {
            self.value = value
        }

        public static func decode(_ decoder: Decoder) throws -> Comment.Identifier {
            return try self.init(integerLiteral: Int.decode(decoder))
        }

        public static func == (lhs: Identifier, rhs: Identifier) -> Bool {
            return lhs.value == rhs.value
        }
    }
}

extension Int {
    public init(_ commentId: Comment.Identifier) {
        self = commentId.value
    }
}

// MARK: - CommentData
public protocol CommentData: Decodable {
    typealias Identifier = Comment.Identifier
    init(
        id: Comment.Identifier,
        body: String,
        likesCount: Int,
        likesURL: URL,
        createdAt: Date,
        updatedAt: Date
    ) throws
}

extension CommentData {
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            body: decoder.decode(forKeyPath: "body"),
            likesCount: decoder.decode(forKeyPath: "likes_count"),
            likesURL: decoder.decode(forKeyPath: "likes_url", Transformer.url),
            createdAt: decoder.decode(forKeyPath: "created_at", Transformer.date),
            updatedAt: decoder.decode(forKeyPath: "updated_at", Transformer.date))
    }
}
