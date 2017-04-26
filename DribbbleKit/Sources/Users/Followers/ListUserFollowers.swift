//
//  ListUserFollowers.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

// MARK: - ListUserFollowers
public struct ListUserFollowers<Data: FollowerData, User: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(data: Data, follower: User)]>

    public var path: String { return "/users/\(username)/followers" }
    private let username: String

    public init(username: String) {
        self.username = username
    }

    public func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [(data: Data, follower: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "follower"))
        }
    }
}

// MARK: - ListAuthenticatedUserFollowers
public struct ListAuthenticatedUserFollowers<Data: FollowerData, User: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(data: Data, follower: User)]>

    public var path: String { return "/user/followers" }

    public init() {}

    public func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [(data: Data, follower: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "follower"))
        }
    }
}
