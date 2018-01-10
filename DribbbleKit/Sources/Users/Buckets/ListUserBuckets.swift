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

// MARK: - ListUserBuckets
public struct ListUserBuckets<Data: BucketData>: PaginatorRequest {
    public typealias Element = Data

    public let path: String
    public let parameters: Any?

    public init(id: User.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/users/\(id.value)/buckets"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String: Any]) throws {
        self.path = path
        self.parameters = parameters
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Data] {
        return try decode(objects)
    }
}

// MARK: - ListAuthenticatedUserBuckets
public struct ListAuthenticatedUserBuckets<Data: BucketData>: PaginatorRequest {
    public typealias Element = Data

    public let path: String
    public let parameters: Any?

    public init(page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/user/buckets"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String: Any]) throws {
        self.path = path
        self.parameters = parameters
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Data] {
        return try decode(objects)
    }
}
