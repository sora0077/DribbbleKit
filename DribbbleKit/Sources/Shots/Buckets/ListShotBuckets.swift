//
//  ListShotBuckets.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/25.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListShotBuckets<Shot: ShotData, User: UserData>: PaginatorRequest {
    public typealias Element = (shot: Shot, user: User)

    public let path: String
    public let parameters: Any?

    public init(id: DribbbleKit.Shot.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/shots/\(id.value)/buckets"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [(shot: Shot, user: User)] {
        return try objects.map {
            try (decode($0), decode($0, rootKeyPath: "user"))
        }
    }
}
