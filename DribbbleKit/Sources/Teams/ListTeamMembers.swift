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

    public var path: String { return "/teams/\(username)/members" }
    private let username: String

    public init(username: String) {
        self.username = username
    }

    public func responseElement(from objects: [Any], urlRequest: HTTPURLResponse) throws -> [Element] {
        return try decode(objects)

    }
}
