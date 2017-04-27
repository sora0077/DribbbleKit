//
//  ListUserFollowing.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

// MARK: - ListUserFollowings
public struct ListUserFollowing<Data: FollowerData, User: UserData>: PaginatorRequest {
    public typealias Element = (data: Data, followee: User)

    public let path: String
    public let parameters: Any?

    public init(username: String) {
        path = "/users/\(username)/following"
        parameters = nil
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [(data: Data, followee: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "followee"))
        }
    }
}

// MARK: - ListAuthenticatedUserFollowing
public struct ListAuthenticatedUserFollowing<Data: FollowerData, User: UserData>: PaginatorRequest {
    public typealias Element = (data: Data, followee: User)

    public let path: String
    public let parameters: Any?

    public init(username: String) {
        path = "/users/following"
        parameters = nil
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [(data: Data, followee: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "followee"))
        }
    }
}
