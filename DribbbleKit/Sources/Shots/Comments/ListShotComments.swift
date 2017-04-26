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

public struct ListShotComments<Comment: CommentData, User: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[(comment: Comment, user: User)]>

    public var path: String { return "/shots/\(id.value)/comments" }
    private let id: DribbbleKit.Shot.Identifier

    public init(id: DribbbleKit.Shot.Identifier) {
        self.id = id
    }

    public func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [(comment: Comment, user: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
