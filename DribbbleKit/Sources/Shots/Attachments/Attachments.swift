//
//  Attachments.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Himotoki

public struct Attachment {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public static func decode(_ e: Extractor) throws -> Attachment.Identifier {
            return try self.init(integerLiteral: Int.decode(e))
        }
    }
}

extension Int {
    public init(_ attachmentId: Attachment.Identifier) {
        self = attachmentId.value
    }
}

public protocol AttachmentData: Decodable {
    init(
        id: Int,
        url: URL,
        thumbnailURL: URL,
        size: Int,
        contentType: String,
        viewsCount: Int,
        createdAt: Date
    ) throws
}

extension AttachmentData {
    public static func decode(_ e: Extractor) throws -> Self {
        return try self.init(
            id: e.value("id"),
            url: e.value("url", Transformer.url),
            thumbnailURL: e.value("thumbnail_url", Transformer.url),
            size: e.value("size"),
            contentType: e.value("content_type"),
            viewsCount: e.value("views_count"),
            createdAt: e.value("created_at", Transformer.date))
    }
}
