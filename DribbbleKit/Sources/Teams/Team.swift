//
//  Team.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Himotoki

public protocol TeamData: Decodable {
    init(
        id: Int,
        name: String,
        username: String,
        htmlURL: URL,
        avatarURL: URL,
        bio: String,
        location: String,
        links: [String: URL],
        bucketsCount: Int,
        commentsRecievedCount: Int,
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
        likeURL: URL,
        shotsURL: URL,
        teamsURL: URL,
        createdAt: Date,
        updatedAt: Date
    ) throws
}

extension TeamData {
    public static func decode(_ e: Extractor) throws -> Self {
        return try self.init(
            id: e.value("id"),
            name: e.value("name"),
            username: e.value("username"),
            htmlURL: e.value("html_url", Transformer.url),
            avatarURL: e.value("avatar_url", Transformer.url),
            bio: e.value("bio"),
            location: e.value("location"),
            links: e.dictionary("links", Transformer.url),
            bucketsCount: e.value("buckets_count"),
            commentsRecievedCount: e.value("comments_received_count"),
            followersCount: e.value("followers_count"),
            followingsCount: e.value("followings_count"),
            likesCount: e.value("likes_count"),
            likesReceivedCount: e.value("likes_received_count"),
            projectsCount: e.value("projects_count"),
            reboundsReceivedCount: e.value("rebounds_received_count"),
            shotsCount: e.value("shots_count"),
            teamsCount: e.value("teams_count"),
            canUploadShot: e.value("can_upload_shot"),
            type: e.value("type"),
            pro: e.value("pro"),
            bucketsURL: e.value("buckets_url", Transformer.url),
            followersURL: e.value("followers_url", Transformer.url),
            followingURL: e.value("following_url", Transformer.url),
            likeURL: e.value("likes_url", Transformer.url),
            shotsURL: e.value("shots_url", Transformer.url),
            teamsURL: e.value("teams_url", Transformer.url),
            createdAt: e.value("created_at", Transformer.date),
            updatedAt: e.value("updated_at", Transformer.date))
    }
}
