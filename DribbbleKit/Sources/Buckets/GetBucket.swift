//
//  GetBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct GetBucket<Bucket: BucketData, User: UserData>: GetRequest {
    public typealias ResponseType = DribbbleKit.Response<(bucket: Bucket, user: User)>

    public var path: String { return "/buckets/\(id.value)" }
    private let id: Bucket.Identifier

    public init(id: Bucket.Identifier) {
        self.id = id
    }

    public func responseData(from object: Any, meta: Meta) throws -> (bucket: Bucket, user: User) {
        return try (decode(object), decode(object, rootKeyPath: "user"))
    }
}
