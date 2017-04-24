//
//  Attachments.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct Attachment {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public static func decode(_ decoder: Decoder) throws -> Attachment.Identifier {
            return try self.init(integerLiteral: Int.decode(decoder))
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
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            url: decoder.decode(forKeyPath: "url", Transformer.url),
            thumbnailURL: decoder.decode(forKeyPath: "thumbnail_url", Transformer.url),
            size: decoder.decode(forKeyPath: "size"),
            contentType: decoder.decode(forKeyPath: "content_type"),
            viewsCount: decoder.decode(forKeyPath: "views_count"),
            createdAt: decoder.decode(forKeyPath: "created_at", Transformer.date))
    }
}
