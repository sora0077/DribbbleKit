//
//  ListShotBuckets.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/25.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListShotBuckets<Shot: ShotData, User: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(shot: Shot, user: User)]>

    public var path: String { return "/shots/\(id.value)/buckets" }
    private let id: DribbbleKit.Shot.Identifier

    public init(shotId: DribbbleKit.Shot.Identifier) {
        id = shotId
    }

    public func response(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse), data: objects.map {
            try (shot: decode($0),
                 user: decode($0, rootKeyPath: "user"))
        })
    }
}
 
