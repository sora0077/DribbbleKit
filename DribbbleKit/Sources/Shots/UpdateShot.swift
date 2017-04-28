//
//  UpdateShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct UpdateShot<Data: ShotData>: PostRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var scope: OAuth.Scope? { return .upload }
    public var path: String { return "/shots/\(id.value)" }

    private let id: Shot.Identifier
    public var title: String?
    public var description: String?
    public var tags: [String]?
    public var teamId: Int?
    public var lowProfile: Bool?

    public init(id: Shot.Identifier) {
        self.id = id
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse), data: decode(object))
    }
}
