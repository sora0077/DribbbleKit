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

public struct ListUserFollowingShots<Shot: ShotData, User: UserData, Team: TeamData>: PaginatorRequest {
    public typealias Element = (shot: Shot, user: User, team: Team?)

    public let path: String
    public let parameters: Any?

    public init(page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/user/following/shots"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String : Any]) throws {
        self.path = path
        self.parameters = parameters
    }

    // swiftlint:disable:next large_tuple
    public func responseElements(from objects: [Any], meta: Meta) throws -> [(shot: Shot, user: User, team: Team?)] {
        return try objects.map {
            try (decode($0),
                 decode($0, rootKeyPath: "user"),
                 decode($0, rootKeyPath: "team", optional: true))
        }
    }
}
