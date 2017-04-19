//
//  Bucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Himotoki

public struct Bucket {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public static func decode(_ e: Extractor) throws -> Bucket.Identifier {
            return try self.init(integerLiteral: Int.decode(e))
        }
    }
}

extension Int {
    public init(_ bucketId: Bucket.Identifier) {
        self = bucketId.value
    }
}
