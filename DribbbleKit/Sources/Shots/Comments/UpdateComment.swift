//
//  UpdateComment.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct UpdateComment<Data: CommentData>: PutRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var scope: OAuth.Scope? { return .comment }
    public var path: String { return "/shots/\(id.value)/comments/\(commentId.value)" }
    public var parameters: Any? {
        return ["body": body]
    }
    private let id: Shot.Identifier
    private let commentId: Comment.Identifier
    public var body: String

    public init(id: Shot.Identifier, commentId: Comment.Identifier, body: String) {
        self.id = id
        self.commentId = commentId
        self.body = body
    }
}
