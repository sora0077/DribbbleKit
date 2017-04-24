//
//  GetUser.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

// MARK: - GetUser
public struct GetUser<Data: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/users/\(username)" }
    private let username: String

    public init(username: String) {
        self.username = username
    }
}

// MARK: - GetAuthenticatedUser
public struct GetAuthenticatedUser<Data: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/user" }

    public init() {}
}
