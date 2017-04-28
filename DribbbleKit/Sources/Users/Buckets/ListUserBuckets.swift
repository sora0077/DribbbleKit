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
public struct ListUserBucket<Data: BucketData>: PaginatorRequest {
    public typealias Element = Data

    public let path: String
    public let parameters: Any?

    public init(username: String, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/users/\(username)/buckets"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Data] {
        return try decode(objects)
    }
}

// MARK: - ListAuthenticatedUserBucket
public struct ListAuthenticatedUserBucket<Data: BucketData>: PaginatorRequest {
    public typealias Element = Data

    public let path: String
    public let parameters: Any?

    public init(page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/user/buckets"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Data] {
        return try decode(objects)
    }
}
