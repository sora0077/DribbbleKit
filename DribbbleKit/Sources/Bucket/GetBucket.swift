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

public struct GetBucket<Data: GetBucketData>: GetRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/buckets/\(id.value)" }
    private let id: Bucket.Identifier

    public init(id: Bucket.Identifier) {
        self.id = id
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decodeValue(object))
    }
}

public protocol GetBucketData: Decodable {
    init(
        id: Bucket.Identifier,
        name: String,
        description: String,
        shotsCount: Int,
        createdAt: Date,
        updatedAt: Date
    ) throws
}

extension GetBucketData {
    public static func decode(_ e: Extractor) throws -> Self {
        return try self.init(
            id: e.value("id"),
            name: e.value("name"),
            description: e.value(""),
            shotsCount: e.value(""),
            createdAt: Transformer.stringToDate.apply(e.value("")),
            updatedAt: Transformer.stringToDate.apply(e.value("")))
    }
}
