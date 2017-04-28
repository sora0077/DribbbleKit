//
//  ListUserLikes.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/28.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

// MARK: - ListUserLikes
public struct ListUserLikes<Like: LikeData, Shot: ShotData, User: UserData, Team: TeamData>: PaginatorRequest {
    public typealias Element = (like: Like, shot: Shot, user: User, team: Team?)

    public let path: String
    public let parameters: Any?

    public init(username: String, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/users/\(username)/likes"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Element] {
        return try objects.map {
            try (decode($0),
                 decode($0, rootKeyPath: "shot"),
                 decode($0, rootKeyPath: ["shot", "user"]),
                 decode($0, rootKeyPath: ["shot", "team"], optional: true))
        }
    }
}

// MARK: - ListUserLikes
public struct ListAuthenticatedUserLikes<Like: LikeData, Shot: ShotData, User: UserData, Team: TeamData>: PaginatorRequest {
    public typealias Element = (like: Like, shot: Shot, user: User, team: Team?)

    public let path: String
    public let parameters: Any?

    public init(page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/user/likes"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Element] {
        return try objects.map {
            try (decode($0),
                 decode($0, rootKeyPath: "shot"),
                 decode($0, rootKeyPath: ["shot", "user"]),
                 decode($0, rootKeyPath: ["shot", "team"], optional: true))
        }
    }
}
