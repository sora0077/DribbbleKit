//
//  ListTeamMembers.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListTeamMembers<Data: UserData>: PaginatorRequest {
    public typealias Element = Data

    public let path: String
    public let parameters: Any?

    public init(username: String) {
        self.path = "/teams/\(username)/members"
        self.parameters = nil
    }

    public init(link: Meta.Link) throws {
        self.path = link.url.path
        self.parameters = link.queries
    }

    public func responseElement(from objects: [Any], meta: Meta) throws -> [Data] {
        return try decode(objects)
    }
}
