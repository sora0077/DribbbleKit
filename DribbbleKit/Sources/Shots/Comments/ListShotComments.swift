//
//  ListShotComments.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListShotComments<Comment: CommentData, User: UserData>: PaginatorRequest {
    public typealias Element = (comment: Comment, user: User)

    public let path: String
    public let parameters: Any?

    public init(id: Shot.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/shots/\(id.value)/comments"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String: Any]) throws {
        self.path = path
        self.parameters = parameters
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [(comment: Comment, user: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
