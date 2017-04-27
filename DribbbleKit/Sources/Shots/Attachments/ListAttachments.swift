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

public struct ListAttachments<Data: AttachmentData>: PaginatorRequest {
    public typealias Element = Data

    public let path: String
    public let parameters: Any?

    public init(id: Shot.Identifier) {
        path = "/shots/\(id.value)/attachments"
        parameters = nil
    }

    public init(link: Meta.Link) throws {
        path = link.url.path
        parameters = link.queries
    }

    public func responseElements(from objects: [Any], meta: Meta) throws -> [Data] {
        return try decode(objects)
    }
}
