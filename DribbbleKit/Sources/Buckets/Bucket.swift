//
//  Bucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct Bucket {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public static func decode(_ decoder: Decoder) throws -> Bucket.Identifier {
            return try self.init(integerLiteral: Int.decode(decoder))
        }
    }
}

extension Int {
    public init(_ bucketId: Bucket.Identifier) {
        self = bucketId.value
    }
}

// MARK: - BucketData
public protocol BucketData: Decodable {
    init(
        id: Bucket.Identifier,
        name: String,
        description: String,
        shotsCount: Int,
        createdAt: Date,
        updatedAt: Date
    ) throws
}

extension BucketData {
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            name: decoder.decode(forKeyPath: "name"),
            description: decoder.decode(forKeyPath: "description"),
            shotsCount: decoder.decode(forKeyPath: "shots_count"),
            createdAt: decoder.decode(forKeyPath: "created_at", Transformer.date),
            updatedAt: decoder.decode(forKeyPath: "updated_at", Transformer.date))
    }
}
