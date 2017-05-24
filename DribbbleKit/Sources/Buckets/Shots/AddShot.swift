//
//  AddShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/28.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct AddShot: PutRequest {
    public typealias ResponseType = DribbbleKit.Response<Void>

    public var scope: OAuth.Scope? { return .write }
    public var path: String { return "/buckets/\(id.value)/shots" }
    public var parameters: Any? {
        return ["shot_id": shotId.value]
    }
    private let id: Bucket.Identifier
    private let shotId: Shot.Identifier

    public init(id: Bucket.Identifier, shotId: Shot.Identifier) {
        self.id = id
        self.shotId = shotId
    }

    public func responseData(from object: Any, meta: Meta) throws {
        return
    }
}
