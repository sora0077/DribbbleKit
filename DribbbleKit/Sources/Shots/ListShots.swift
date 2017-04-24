//
//  ListShots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListShots<Shot: ShotData, User: UserData, Team: TeamData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(shot: Shot, user: User, team: Team?)]>

    public var path: String { return "/shots" }

    public init() {}

    public func response(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: objects.map {
            try (shot: decode($0),
                 user: decode($0, rootKeyPath: "user"),
                 team: optional(decode($0, rootKeyPath: "team"), keyPath: "team"))
        })
    }
}
