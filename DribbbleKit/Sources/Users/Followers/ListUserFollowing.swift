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

    public init(id: User.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/users/\(id.value)/following"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String : Any]) throws {
        self.path = path
        self.parameters = parameters
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

    public init(page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/users/following"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String : Any]) throws {
        self.path = path
        self.parameters = parameters
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [(data: Data, followee: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "followee"))
        }
    }
}
