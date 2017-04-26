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

    public var path: String { return "/shots/\(id.value)/comments/\(commentId.value)" }
    private let id: DribbbleKit.Shot.Identifier
    private let commentId: DribbbleKit.Comment.Identifier
    public var body: String

    public init(id: DribbbleKit.Shot.Identifier, commentId: DribbbleKit.Comment.Identifier, body: String) {
        self.id = id
        self.commentId = commentId
        self.body = body
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try DribbbleKit.Response(meta: Meta(urlResponse), data: decode(object))
    }
}
