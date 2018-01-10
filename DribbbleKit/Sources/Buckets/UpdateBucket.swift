//
//  UpdateBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct UpdateBucket<D: BucketData>: PutRequest {
    public typealias Data = D
    public typealias Response = DribbbleKit.Response<Data>

    public var scope: OAuth.Scope? { return .write }
    public var path: String { return "/buckets/\(id.value)" }
    public var parameters: Any? {
        return [
            "name": name,
            "description": description].cleaned
    }
    private let id: Bucket.Identifier
    private let name: String
    private let description: String?

    public init(id: Bucket.Identifier, name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}
