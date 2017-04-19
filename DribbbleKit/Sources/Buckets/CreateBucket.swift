//
//  CreateBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct CreateBucket<Data: BucketData>: PostRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/buckets" }
    public var parameters: Any? {
        return [
            "name": name,
            "description": description]
    }
    private let name: String
    private let description: String?

    public init(name: String, description: String? = nil) {
        self.name = name
        self.description = description
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decodeValue(object))
    }
}
