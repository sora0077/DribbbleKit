//
//  FollowUser.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct FollowUser: PutRequest {
    public typealias Response = DribbbleKit.Response<Void>
    
    public var scope: OAuth.Scope? { return .write }
    public var path: String { return "/users/\(target)/follow" }
    private let target: String

    public init(target: String) {
        self.target = target
    }

    public func responseData(from object: Any, meta: Meta) throws {
        return
    }
}
