//
//  ListShotLikes.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListShotLikes<Like: LikeData, User: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(like: Like, user: User)]>

    public var path: String { return "/shots/\(id.value)/likes" }
    private let id: Shot.Identifier

    public init(id: Shot.Identifier) {
        self.id = id
    }

    public func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [(like: Like, user: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
