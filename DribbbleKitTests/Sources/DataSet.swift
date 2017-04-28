//
//  DataSet.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import DribbbleKit
import Alter

struct DataSet {
    private init() {}

    struct ShotEntity: ShotData {
        init(id: Shot.Identifier,
             title: String,
             description: String,
             width: Int,
             height: Int,
             images: [String : URL],
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
            ) throws {

        }
    }

    struct UserEntity: UserData {
        init(id: Int,
             name: String,
             username: String,
             htmlURL: URL,
             avatarURL: URL,
             bio: String,
             location: String,
             links: [String : URL],
             bucketsCount: Int,
             commentsRecievedCount: Int,
             followersCount: Int,
             followingsCount: Int,
             likesCount: Int,
             likesReceivedCount: Int,
             projectsCount: Int,
             reboundsReceivedCount: Int,
             shotsCount: Int, teamsCount: Int,
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
            ) throws {
        }
    }

    struct TeamEntity: TeamData {
        init(id: Int,
             name: String,
             username: String,
             htmlURL: URL,
             avatarURL: URL,
             bio: String,
             location: String,
             links: [String : URL],
             bucketsCount: Int,
             commentsReceivedCount: Int,
             followersCount: Int,
             followingsCount: Int,
             likesCount: Int,
             likesReceivedCount: Int,
             membersCount: Int,
             projectsCount: Int,
             reboundsReceivedCount: Int,
             shotsCount: Int,
             canUploadShot: Bool,
             type: String,
             pro: Bool,
             bucketsURL: URL,
             followersURL: URL,
             followingURL: URL,
             likesURL: URL,
             membersURL: URL,
             shotsURL: URL,
             teamShotsURL: URL,
             createdAt: Date,
             updatedAt: Date
            ) throws {
        }
    }

    struct BucketEntity: BucketData {
        init(id: Bucket.Identifier,
             name: String,
             description: String,
             shotsCount: Int,
             createdAt: Date,
             updatedAt: Date
            ) throws {
        }
    }

    struct AttachmentEntity: AttachmentData {
        init(id: Int,
             url: URL,
             thumbnailURL: URL,
             size: Int,
             contentType: String,
             viewsCount: Int,
             createdAt: Date
            ) throws {
        }
    }

    struct CommentEntity: CommentData {
        init(id: Comment.Identifier,
             body: String,
             likesCount: Int,
             likesURL: URL,
             createdAt: Date,
             updatedAt: Date
            ) throws {
        }
    }

    struct ProjectEntity: ProjectData {
        init(id: Project.Identifier,
             name: String,
             description: String,
             shotsCount: Int,
             createdAt: Date,
             updatedAt: Date
            ) throws {
        }
    }

    struct LikeEntity: LikeData {
        let id: Int
        init(id: Int, createdAt: Date) throws {
            self.id = id
        }
    }
}

extension DataSet {
    static let emptyURLResponse = HTTPURLResponse()

    private static func build(statusCode: Int, headerFields: [String: String]? = nil) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: URL(string: "http://dummy.com")!,
            statusCode: statusCode,
            httpVersion: "HTTP/1.1",
            headerFields: headerFields)!
    }

    static func validURLResponse(statusCode: Int = 200, headerFields: [String: String]? = nil) -> HTTPURLResponse {
        return build(statusCode: statusCode, headerFields: headerFields)
    }

    static func linkURLResponse(prev: URL?, next: URL?, headerFields: [String: String]? = nil) -> HTTPURLResponse {
        var headers = headerFields ?? [:]
        var prevString: String?
        var nextString: String?
        if let prev = prev?.absoluteString {
            prevString = "<\(prev)>; rel=\"prev\""
        }
        if let next = next?.absoluteString {
            nextString = "<\(next)>; rel=\"next\""
        }
        let link = [prevString, nextString].flatMap { $0 }.joined(separator: ", ")
        headers["Link"] = link
        return build(statusCode: 200, headerFields: headers)
    }

    static let badRequestURLResponse = build(statusCode: 400)

    static let notFoundURLResponse = build(statusCode: 404)

    static func rateLimitURLResponse(headerFields: [String: String]? = nil) -> HTTPURLResponse {
        return build(statusCode: 429, headerFields: headerFields)
    }
}
