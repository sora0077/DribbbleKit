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

public struct ListTeamShots<Shot: ShotData, User: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(shot: Shot, user: User)]>

    public var path: String { return "/teams/\(username)/shots" }
    private let username: String

    public init(username: String) {
        self.username = username
    }

    public func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [(shot: Shot, user: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
