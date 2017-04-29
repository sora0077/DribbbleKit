//
//  DeleteComment.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct DeleteComment: DeleteRequest {
    public typealias Response = DribbbleKit.Response<Void>

    public var scope: OAuth.Scope? { return .comment }
    public var path: String { return "/shots/\(id.value)/comments/\(commentId.value)" }
    private let id: Shot.Identifier
    private let commentId: Comment.Identifier

    public init(id: Shot.Identifier, commentId: Comment.Identifier) {
        self.id = id
        self.commentId = commentId
    }
}
