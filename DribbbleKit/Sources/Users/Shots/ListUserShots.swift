//
//  ListUserShots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/28.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

// MARK: - ListUserShots
public struct ListUserShots<Shot: ShotData, Team: TeamData>: PaginatorRequest {
    public typealias Element = (shot: Shot, team: Team?)

    public let path: String
    public let parameters: Any?

    public init(id: User.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/users/\(id.value)/shots"
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
            try (decode($0), decode($0, rootKeyPath: "team", optional: true))
        }
    }
}

// MARK: - ListAuthenticatedUserShots
public struct ListAuthenticatedUserShots<Shot: ShotData, Team: TeamData>: PaginatorRequest {
    public typealias Element = (shot: Shot, team: Team?)

    public let path: String
    public let parameters: Any?

    public init(page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/user/shots"
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
            try (decode($0), decode($0, rootKeyPath: "team", optional: true))
        }
    }
}
