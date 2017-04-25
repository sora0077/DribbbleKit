//
//  Shots.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct Shot {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public static func decode(_ decoder: Decoder) throws -> Shot.Identifier {
            return try self.init(integerLiteral: Int.decode(decoder))
        }
    }
}

extension Int {
    public init(_ shotId: Shot.Identifier) {
        self = shotId.value
    }
}

// MARK: - ShotData
public protocol ShotData: Decodable {
    init(
        id: Shot.Identifier,
        title: String,
        description: String,
        width: Int,
        height: Int,
        images: [String: URL],
        viewsCount: Int,
        likesCount: Int,
        commentsCount: Int,
        attachmentsCount: Int,
        reboundsCount: Int,
        bucketsCount: Int,
        createdAt: Date,
        updatedAt: Date,
        htmlURL: URL,
        attachmentsURL: URL,
        bucketsURL: URL,
        commentsURL: URL,
        likesURL: URL,
        projectsURL: URL,
        reboundsURL: URL,
        animated: Bool,
        tags: [String]
    ) throws
}

extension ShotData {
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            title: decoder.decode(forKeyPath: "title"),
            description: decoder.decode(forKeyPath: "description"),
            width: decoder.decode(forKeyPath: "width"),
            height: decoder.decode(forKeyPath: "height"),
            images: decoder.decode(forKeyPath: "images", skipInvalidElements: true, Transformer.url),
            viewsCount: decoder.decode(forKeyPath: "views_count"),
            likesCount: decoder.decode(forKeyPath: "likes_count"),
            commentsCount: decoder.decode(forKeyPath: "comments_count"),
            attachmentsCount: decoder.decode(forKeyPath: "attachments_count"),
            reboundsCount: decoder.decode(forKeyPath: "rebounds_count"),
            bucketsCount: decoder.decode(forKeyPath: "buckets_count"),
            createdAt: decoder.decode(forKeyPath: "created_at", Transformer.date),
            updatedAt: decoder.decode(forKeyPath: "updated_at", Transformer.date),
            htmlURL: decoder.decode(forKeyPath: "html_url", Transformer.url),
            attachmentsURL: decoder.decode(forKeyPath: "attachments_url", Transformer.url),
            bucketsURL: decoder.decode(forKeyPath: "attachments_url", Transformer.url),
            commentsURL: decoder.decode(forKeyPath: "comments_url", Transformer.url),
            likesURL: decoder.decode(forKeyPath: "likes_url", Transformer.url),
            projectsURL: decoder.decode(forKeyPath: "projects_url", Transformer.url),
            reboundsURL: decoder.decode(forKeyPath: "rebounds_url", Transformer.url),
            animated: decoder.decode(forKeyPath: "animated"),
            tags: decoder.decode(forKeyPath: "tags"))
    }
}
