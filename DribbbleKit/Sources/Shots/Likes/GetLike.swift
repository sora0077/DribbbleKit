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
    public typealias Response = DribbbleKit.Response<Data?>

    public var path: String { return "/shots/\(id.value)/like" }
    private let id: Shot.Identifier

    public init(id: Shot.Identifier) {
        self.id = id
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        if urlResponse.statusCode == 404 {
            return Response(meta: Meta(urlResponse), data: nil)
        }
        return try Response(meta: Meta(urlResponse), data: decode(object))
    }
}
