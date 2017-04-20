//
//  ListTeamMembers.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct ListTeamMembers<Data: UserData>: ListRequest {
    public typealias Response = DribbbleKit.Response<[Data]>

    public var path: String { return "/teams/\(username)/members" }
    private let username: String

    public init(username: String) {
        self.username = username
    }

    public func response(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Response {
        return try Response(meta: Meta(urlResponse: urlResponse), data: decodeArray(objects))
    }
}
