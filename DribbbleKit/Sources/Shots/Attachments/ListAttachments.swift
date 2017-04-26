//
//  ListAttachments.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListAttachments<Data: AttachmentData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[Data]>

    public var path: String { return "/shots/\(id.value)/attachments" }
    private let id: Shot.Identifier

    public init(shotId: Shot.Identifier) {
        self.id = shotId
    }

    public func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [Data] {
        return try decode(objects)
    }
}
