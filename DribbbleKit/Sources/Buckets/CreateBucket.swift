//
//  CreateBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct CreateBucket<D: BucketData>: PostRequest {
    public typealias Data = D
    public typealias Response = DribbbleKit.Response<Data>

    public var scope: OAuth.Scope? { return .write }
    public var path: String { return "/buckets" }
    public var parameters: Any? {
        return [
            "name": name,
            "description": description].cleaned
    }
    private let name: String
    private let description: String?

    public init(name: String, description: String? = nil) {
        self.name = name
        self.description = description
    }
}
