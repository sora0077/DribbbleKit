//
//  ListUserFollowingShots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListUserFollowingShots<Shot: ShotData, User: UserData, Team: TeamData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(shot: Shot, user: User, team: Team?)]>

    public var path: String { return "/user/following/shots" }

    public init() {}

    // swiftlint:disable:next large_tuple
    public func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [(shot: Shot, user: User, team: Team?)] {
        return try objects.map {
            try (decode($0),
                 decode($0, rootKeyPath: "user"),
                 decode($0, rootKeyPath: "team", optional: true))
        }
    }
}
