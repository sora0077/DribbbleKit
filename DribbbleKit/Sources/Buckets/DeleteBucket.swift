//
//  DeleteBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct DeleteBucket: DeleteRequest {
    public typealias Response = DribbbleKit.Response<Void>

    public var path: String { return "/buckets" }

    public init() {}

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return Response(meta: Meta(urlResponse: urlResponse), data: ())
    }
}
