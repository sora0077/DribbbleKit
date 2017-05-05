//
//  GetUserFollowing.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct GetUserFollowingUser: GetRequest {
    public typealias Response = DribbbleKit.Response<Bool>

    public var path: String { return "/users\(id.value)/following/\(targetId.value)" }
    private let id: User.Identifier
    private let targetId: User.Identifier

    public init(id: User.Identifier, targetId: User.Identifier) {
        self.id = id
        self.targetId = targetId
    }

    public func intercept(object: Any, meta: Meta) throws {}

    public func responseData(from object: Any, meta: Meta) throws -> Bool {
        return meta.status == 204
    }
}

public struct GetAuthenticatedUserFollowing: GetRequest {
    public typealias Response = DribbbleKit.Response<Bool>

    public var path: String { return "/user/following/\(target)" }
    private let target: String

    public init(target: String) {
        self.target = target
    }

    public func responseData(from object: Any, meta: Meta) throws -> Bool {
        return meta.status == 204
    }
}
