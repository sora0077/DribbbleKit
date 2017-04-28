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

public struct CreateShot: PostRequest {
    public typealias Response = DribbbleKit.Response<Shot.Identifier>

    public var scope: OAuth.Scope? { return .upload }
    public var path: String { return "/shots" }

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

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let meta = Meta(urlResponse)
        guard let location = meta["Location"] as? String,
            let id = location.components(separatedBy: "/").last.flatMap({ Int($0) }) else {
            throw DribbbleError.unexpected
        }
        return Response(meta: meta, data: Shot.Identifier(integerLiteral: id))
    }
}
