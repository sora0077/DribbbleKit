//
//  GetComment.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct GetComment<Comment: CommentData, User: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<(comment: Comment, user: User)>

    public var path: String { return "/shots/\(id.value)/comments/\(commentId.value)" }
    private let id: Shot.Identifier
    private let commentId: Comment.Identifier

    public init(id: Shot.Identifier, commentId: Comment.Identifier) {
        self.id = id
        self.commentId = commentId
    }

    public func responseData(from object: Any, meta: Meta) throws -> (comment: Comment, user: User) {
        return try (decode(object), decode(object, rootKeyPath: "user"))
    }
}
