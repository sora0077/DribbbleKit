//
//  UpdateShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct UpdateShot<D: ShotData>: PostRequest {
    public typealias Data = D
    public typealias Response = DribbbleKit.Response<Data>

    public var scope: OAuth.Scope? { return .upload }
    public var path: String { return "/shots/\(id.value)" }
    public var parameters: Any? {
        return [
            "title": title,
            "description": description,
            "tags": tags,
            "team_id": teamId,
            "low_profile": lowProfile].cleaned
    }

    private let id: Shot.Identifier
    public var title: String?
    public var description: String?
    public var tags: [String]?
    public var teamId: Int?
    public var lowProfile: Bool?

    public init(id: Shot.Identifier) {
        self.id = id
    }
}
