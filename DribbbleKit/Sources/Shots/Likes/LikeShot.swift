//
//  LikeShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct LikeShot<Data: LikeData>: PostRequest {
    public typealias ResponseType = DribbbleKit.Response<Data>

    public var scope: OAuth.Scope? { return .write }
    public var path: String { return "/shots/\(id.value)/like" }

    private let id: Shot.Identifier

    public init(id: Shot.Identifier) {
        self.id = id
    }
}
