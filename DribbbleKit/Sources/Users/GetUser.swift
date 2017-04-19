//
//  GetUser.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

// MARK: - GetUser
public struct GetUser<Data: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/users/\(username)" }
    private let username: String

    public init(username: String) {
        self.username = username
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decodeValue(object))
    }
}

// MARK: - GetAuthenticatedUser
public struct GetAuthenticatedUser<Data: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/user" }

    public init() {}

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decodeValue(object))
    }
}
