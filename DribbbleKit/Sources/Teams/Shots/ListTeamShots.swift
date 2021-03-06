//
//  ListTeamShots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListTeamShots<Shot: ShotData, User: UserData>: PaginatorRequest {
    public typealias Element = (shot: Shot, user: User)

    public let path: String
    public let parameters: Any?

    public init(id: Team.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/teams/\(id.value)/shots"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String : Any]) throws {
        self.path = path
        self.parameters = parameters
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Element] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
