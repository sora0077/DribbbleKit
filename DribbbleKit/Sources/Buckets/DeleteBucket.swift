//
//  DeleteBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct DeleteBucket: DeleteRequest {
    public typealias Response = DribbbleKit.Response<Void>

    public var scope: OAuth.Scope? { return .write }
    public var path: String { return "/buckets/\(id.value)" }
    private let id: DribbbleKit.Bucket.Identifier

    public init(id: DribbbleKit.Bucket.Identifier) {
        self.id = id
    }
}
