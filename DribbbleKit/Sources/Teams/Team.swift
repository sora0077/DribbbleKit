//
//  Team.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Himotoki

public protocol TeamData {
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
