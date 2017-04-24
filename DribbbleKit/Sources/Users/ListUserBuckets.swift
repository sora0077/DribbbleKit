//
//  ListUserBuckets.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

// MARK: - ListUserBucket
public struct ListUserBucket<Data: BucketData>: GetRequest {
    public typealias Response = DribbbleKit.Response<[Data]>

    public var path: String { return "/users/\(username)/buckets" }
    private let username: String

    public init(username: String) {
        self.username = username
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decode(object))
    }
}

// MARK: - ListAuthenticatedUserBucket
public struct ListAuthenticatedUserBucket<Data: BucketData>: GetRequest {
    public typealias Response = DribbbleKit.Response<[Data]>

    public var path: String { return "/user/buckets" }

    public init() {}

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decode(object))
    }
}
