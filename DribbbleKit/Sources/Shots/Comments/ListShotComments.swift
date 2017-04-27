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

    public init(id: DribbbleKit.Shot.Identifier) {
        path = "/shots/\(id.value)/comments"
        parameters = nil
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [(comment: Comment, user: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
