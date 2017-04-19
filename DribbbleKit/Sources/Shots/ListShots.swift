//
//  ListShots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct ListShots<Shot: ShotData, User: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<[(shot: Shot, user: User)]>

    public var path: String { return "/shots" }

    public init() {}

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let list = object as? [Any] else {
            throw DecodeError.typeMismatch(expected: "Array", actual: "\(object)", keyPath: .empty)
        }
        return try Response(meta: Meta(urlResponse: urlResponse), data: list.map {
            try (shot: decodeValue($0),
                 user: decodeValue($0, rootKeyPath: "user"))
        })
    }
}
