//
//  GetLike.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct GetLike<Data: LikeData>: GetRequest {
    public typealias ResponseType = DribbbleKit.Response<Data?>

    public var path: String { return "/shots/\(id.value)/like" }
    private let id: Shot.Identifier

    public init(id: Shot.Identifier) {
        self.id = id
    }

    public func intercept(object: Any, meta: Meta) throws {}

    public func responseData(from object: Any, meta: Meta) throws -> Data? {
        return meta.status == 404  ? nil : try decode(object)
    }
}
