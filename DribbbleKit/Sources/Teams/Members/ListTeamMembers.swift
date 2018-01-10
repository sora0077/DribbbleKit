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

    public init(id: User.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/teams/\(id.value)/members"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String: Any]) throws {
        self.path = path
        self.parameters = parameters
    }
}
