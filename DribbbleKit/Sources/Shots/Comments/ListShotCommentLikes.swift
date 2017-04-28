//
//  ListShotCommentLikes.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListShotCommentLikes<Like: LikeData, User: UserData>: PaginatorRequest {
    public typealias Element = (like: Like, user: User)

    public let path: String
    public let parameters: Any?

    public init(id: DribbbleKit.Shot.Identifier, commentId: DribbbleKit.Comment.Identifier,
                page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/shots/\(id.value)/comments/\(commentId.value)/likes"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [(like: Like, user: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
