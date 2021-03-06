//
//  ListUserTeams.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/28.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

// MARK: - ListUserTeams
public struct ListUserTeams<Team: TeamData>: PaginatorRequest {
    public typealias Element = Team

    public let path: String
    public let parameters: Any?

    public init(id: User.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/users/\(id.value)/teams"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String : Any]) throws {
        self.path = path
        self.parameters = parameters
    }
}

// MARK: - ListAuthenticatedUserTeams
public struct ListAuthenticatedUserTeams<Team: TeamData>: PaginatorRequest {
    public typealias Element = Team

    public let path: String
    public let parameters: Any?

    public init(page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/user/teams"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String : Any]) throws {
        self.path = path
        self.parameters = parameters
    }
}
