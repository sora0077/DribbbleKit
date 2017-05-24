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
    public typealias ResponseType = DribbbleKit.Response<Data>

    public var path: String { return "/users/\(id.value)" }
    private let id: User.Identifier

    public init(id: User.Identifier) {
        self.id = id
    }
}

// MARK: - GetAuthenticatedUser
public struct GetAuthenticatedUser<Data: UserData>: GetRequest {
    public typealias ResponseType = DribbbleKit.Response<Data>

    public var path: String { return "/user" }

    public init() {}
}
