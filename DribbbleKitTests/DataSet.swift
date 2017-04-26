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
             likeURL: URL,
             shotsURL: URL,
             teamsURL: URL,
             createdAt: Date,
             updatedAt: Date
            ) throws {
        }
    }
}

extension DataSet {
    static let emptyURLResponse = HTTPURLResponse()

    static let badRequestURLResponse = HTTPURLResponse(
        url: URL(string: "http://dummy.com")!,
        statusCode: 400,
        httpVersion: "HTTP/1.1",
        headerFields: nil)!

    static func rateLimitURLResponse(headerFields: [String: String]? = nil) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: URL(string: "http://dummy.com")!,
            statusCode: 429,
            httpVersion: "HTTP/1.1",
            headerFields: headerFields)!
    }
}
