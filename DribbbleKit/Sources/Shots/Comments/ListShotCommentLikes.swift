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

public struct ListShotCommentLikes<Comment: CommentData, User: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(comment: Comment, user: User)]>

    public var path: String { return "/shots/\(id.value)/comments/\(commentId.value)/likes" }
    private let id: DribbbleKit.Shot.Identifier
    private let commentId: DribbbleKit.Comment.Identifier

    public init(id: DribbbleKit.Shot.Identifier, commentId: DribbbleKit.Comment.Identifier) {
        self.id = id
        self.commentId = commentId
    }

    public func response(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse), data: objects.map {
            try (shot: decode($0),
                 user: decode($0, rootKeyPath: "user"))
        })
    }
}
