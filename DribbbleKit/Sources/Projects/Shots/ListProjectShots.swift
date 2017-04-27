//
//  ListProjectShots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/25.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListProjectShots<Project: ProjectData, User: UserData, Team: TeamData>: PaginatorRequest {
    public typealias Element = (project: Project, user: User, team: Team)

    public let path: String
    public let parameters: Any?

    public init(projectId: DribbbleKit.Project.Identifier, page: Int? = nil, perPage: Int? = configuration.perPage) {
        path = "/projects/\(projectId.value)/shots"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    // swiftlint:disable:next large_tuple
    public func responseElements(from objects: [Any], meta: Meta) throws -> [(project: Project, user: User, team: Team)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"), decode($0, rootKeyPath: "team"))
        }
    }
}
