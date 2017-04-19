//
//  GetBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct GetBucket<Bucket: BucketData, User: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<(bucket: Bucket, user: User)>

    public var path: String { return "/buckets/\(id.value)" }
    private let id: DribbbleKit.Bucket.Identifier

    public init(id: DribbbleKit.Bucket.Identifier) {
        self.id = id
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: (decodeValue(object), decodeValue(object, rootKeyPath: "user")))
    }
}
