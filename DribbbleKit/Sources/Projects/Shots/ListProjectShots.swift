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

public struct ListProjectShots<Project: ProjectData, User: UserData, Team: TeamData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(project: Project, user: User, team: Team)]>

    public var path: String { return "/projects/\(id.value)/shots" }
    private let id: DribbbleKit.Project.Identifier

    public init(projectId: DribbbleKit.Project.Identifier) {
        self.id = projectId
    }

    public func response(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse), data: objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"), decode($0, rootKeyPath: "team"))
        })
    }
}
