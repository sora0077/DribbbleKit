//
//  GetShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct GetShot<Shot: ShotData, User: UserData>: GetRequest {
    public typealias Response = DribbbleKit.Response<(shot: Shot, user: User)>

    public var path: String { return "/shots/\(id.value)" }
    private let id: DribbbleKit.Shot.Identifier

    public init(id: DribbbleKit.Shot.Identifier) {
        self.id = id
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: (
            shot: decodeValue(object),
            user: decodeValue(object, rootKeyPath: "user")))
    }
}
