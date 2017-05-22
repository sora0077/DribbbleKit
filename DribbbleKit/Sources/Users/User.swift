//
//  User.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct User {
    public struct Identifier: Decodable, Hashable, ExpressibleByIntegerLiteral {
        let value: Int
        public var hashValue: Int { return value.hashValue }

        public init(integerLiteral value: Int) {
            self.value = value
        }

        public init(_ value: Int) {
            self.value = value
        }

        public static func decode(_ decoder: Decoder) throws -> User.Identifier {
            return try self.init(integerLiteral: Int.decode(decoder))
        }

        public static func == (lhs: Identifier, rhs: Identifier) -> Bool {
            return lhs.value == rhs.value
        }
    }
}

extension Int {
    public init(_ userId: User.Identifier) {
        self = userId.value
    }
}

// MARK: - UserData
public protocol UserData: Decodable {
    typealias Identifier = User.Identifier
    init(
        id: User.Identifier,
        name: String,
        username: String,
        htmlURL: URL,
        avatarURL: URL,
        bio: String,
        location: String,
        links: [String: URL],
        bucketsCount: Int,
        commentsReceivedCount: Int,
        followersCount: Int,
        followingsCount: Int,
        likesCount: Int,
        likesReceivedCount: Int,
        projectsCount: Int,
        reboundsReceivedCount: Int,
        shotsCount: Int,
        teamsCount: Int,
        canUploadShot: Bool,
        type: String,
        pro: Bool,
        bucketsURL: URL,
        followersURL: URL,
        followingURL: URL,
        likesURL: URL,
        shotsURL: URL,
        teamsURL: URL,
        createdAt: Date,
        updatedAt: Date
    ) throws
}

extension UserData {
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            name: decoder.decode(forKeyPath: "name"),
            username: decoder.decode(forKeyPath: "username"),
            htmlURL: decoder.decode(forKeyPath: "html_url", Transformer.url),
            avatarURL: decoder.decode(forKeyPath: "avatar_url", Transformer.url),
            bio: decoder.decode(forKeyPath: "bio"),
            location: decoder.decode(forKeyPath: "location"),
            links: decoder.decode(forKeyPath: "links", Transformer.url),
            bucketsCount: decoder.decode(forKeyPath: "buckets_count"),
            commentsReceivedCount: decoder.decode(forKeyPath: "comments_received_count"),
            followersCount: decoder.decode(forKeyPath: "followers_count"),
            followingsCount: decoder.decode(forKeyPath: "followings_count"),
            likesCount: decoder.decode(forKeyPath: "likes_count"),
            likesReceivedCount: decoder.decode(forKeyPath: "likes_received_count"),
            projectsCount: decoder.decode(forKeyPath: "projects_count"),
            reboundsReceivedCount: decoder.decode(forKeyPath: "rebounds_received_count"),
            shotsCount: decoder.decode(forKeyPath: "shots_count"),
            teamsCount: decoder.decode(forKeyPath: "teams_count", optional: true) ?? 0,
            canUploadShot: decoder.decode(forKeyPath: "can_upload_shot"),
            type: decoder.decode(forKeyPath: "type"),
            pro: decoder.decode(forKeyPath: "pro"),
            bucketsURL: decoder.decode(forKeyPath: "buckets_url", Transformer.url),
            followersURL: decoder.decode(forKeyPath: "followers_url", Transformer.url),
            followingURL: decoder.decode(forKeyPath: "following_url", Transformer.url),
            likesURL: decoder.decode(forKeyPath: "likes_url", Transformer.url),
            shotsURL: decoder.decode(forKeyPath: "shots_url", Transformer.url),
            teamsURL: decoder.decode(forKeyPath: "teams_url", Transformer.url),
            createdAt: decoder.decode(forKeyPath: "created_at", Transformer.date),
            updatedAt: decoder.decode(forKeyPath: "updated_at", Transformer.date))
    }
}
