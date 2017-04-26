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

    public var path: String { return "/users\(username)/following/\(target)" }
    private let username: String
    private let target: String

    public init(username: String, target: String) {
        self.username = username
        self.target = target
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return Response(meta: Meta(urlResponse), data: urlResponse.statusCode == 204)
    }
}

public struct GetAuthenticatedUserFollowing: GetRequest {
    public typealias Response = DribbbleKit.Response<Bool>

    public var path: String { return "/user/following/\(target)" }
    private let target: String

    public init(target: String) {
        self.target = target
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return Response(meta: Meta(urlResponse), data: urlResponse.statusCode == 204)
    }
}
