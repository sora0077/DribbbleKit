//
//  GetShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct GetShot<Shot: ShotData, User: UserData, Team: TeamData>: GetRequest {
    public typealias Response = DribbbleKit.Response<(shot: Shot, userOrTeam: UserOrTeam<User, Team>, team: Team?)>

    public var path: String { return "/shots/\(id.value)" }
    private let id: Shot.Identifier

    public init(id: Shot.Identifier) {
        self.id = id
    }

    // swiftlint:disable:next large_tuple
    public func responseData(from object: Any, meta: Meta) throws -> (shot: Shot, userOrTeam: UserOrTeam<User, Team>, team: Team?) {
        return try (decode(object),
                    decode(object, rootKeyPath: "user"),
                    decode(object, rootKeyPath: "team", optional: true))
    }
}
