//
//  GetAttachment.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct GetAttachments<Data: AttachmentData>: ListRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/shots/\(shotId)/attachments/\(id.value)" }
    private let shotId: Shot.Identifier
    private let id: Attachment.Identifier

    public init(shotId: Shot.Identifier, id: Attachment.Identifier) {
        self.shotId = shotId
        self.id = id
    }

    public func response(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decodeValue(objects))
    }
}
