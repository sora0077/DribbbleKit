//
//  GetBucket.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct GetBucket<Data: GetBucketData>: GetRequest {
    public typealias Response = DribbbleKit.Response<Data>

    public var path: String { return "/buckets/\(id.value)" }
    private let id: Bucket.Identifier

    public init(id: Bucket.Identifier) {
        self.id = id
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decodeValue(object))
    }
}

public protocol GetBucketData: Decodable {
    init(
        id: Bucket.Identifier,
        name: String,
        description: String,
        shotsCount: Int,
        bucketsCount: Int,
        commentsRecievedCount: Int,
        followersCount: Int,
        followingsCount: Int,
        likesCount: Int,
        likesReceivedCount: Int,
        projectsCount: Int,
        reboundsReceivedCount: Int,
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

extension GetBucketData {
    public static func decode(_ e: Extractor) throws -> Self {
        return try self.init(
            id: e.value("id"),
            name: e.value("name"),
            description: e.value("description"),
            shotsCount: e.value("shots_count"),
            bucketsCount: e.value("buckets_count"),
            commentsRecievedCount: e.value("comments_received_count"),
            followersCount: e.value("followers_count"),
            followingsCount: e.value("followings_count"),
            likesCount: e.value("likes_count"),
            likesReceivedCount: e.value("likes_received_count"),
            projectsCount: e.value("projects_count"),
            reboundsReceivedCount: e.value("rebounds_received_count"),
            teamsCount: e.value("teams_count"),
            canUploadShot: e.value("can_upload_shot"),
            type: e.value("type"),
            pro: e.value("pro"),
            bucketsURL: Transformer.stringToURL.apply(e.value("buckets_url")),
            followersURL: Transformer.stringToURL.apply(e.value("followers_count")),
            followingURL: Transformer.stringToURL.apply(e.value("following_url")),
            likeURL: Transformer.stringToURL.apply(e.value("likes_url")),
            shotsURL: Transformer.stringToURL.apply(e.value("shots_url")),
            teamsURL: Transformer.stringToURL.apply(e.value("teams_url")),
            createdAt: Transformer.stringToDate.apply(e.value("created_at")),
            updatedAt: Transformer.stringToDate.apply(e.value("updated_at")))
    }
}
