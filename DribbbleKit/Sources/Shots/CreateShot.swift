//
//  CreateShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

private func make(value: Any?, key: String) -> MultipartFormDataBodyParameters.Part? {
    guard let value = value else { return nil }
    return try! MultipartFormDataBodyParameters.Part(value: value, name: key)  // swiftlint:disable:this force_try
}

private func make(data value: Data, key: String) -> MultipartFormDataBodyParameters.Part {
    return MultipartFormDataBodyParameters.Part(data: value, name: key)
}

public struct CreateShot: PostRequest {
    public typealias ResponseType = DribbbleKit.Response<Shot.Identifier>

    public var scope: OAuth.Scope? { return .upload }
    public var path: String { return "/shots" }
    public var bodyParameters: BodyParameters? {
        return MultipartFormDataBodyParameters(parts: [
            make(value: title, key: "title"),
            make(data: image, key: "image"),
            make(value: description, key: "description"),
            make(value: tags, key: "tags"),
            make(value: teamId, key: "team_id"),
            make(value: reboundSourceId, key: "rebound_source_id"),
            make(value: lowProfile, key: "low_profile")
            ].flatMap { $0 })
    }

    public var title: String
    public var image: Data
    public var description: String?
    public var tags: [String]?
    public var teamId: Int?
    public var reboundSourceId: Shot.Identifier?
    public var lowProfile: Bool?

    public init(title: String, image: Data) {
        self.title = title
        self.image = image
    }

    public func responseData(from object: Any, meta: Meta) throws -> Shot.Identifier {
        guard let location = meta["Location"] as? String,
            let id = location.components(separatedBy: "/").last.flatMap({ Int($0) }) else {
                throw DribbbleError.unexpected
        }
        return Shot.Identifier(integerLiteral: id)
    }
}
