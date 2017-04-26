//
//  Followers.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public protocol FollowerData: Decodable {
    init(
        id: Int,
        createdAt: Date
    ) throws
}

extension FollowerData {
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            createdAt: decoder.decode(forKeyPath: "created_at", Transformer.date))
    }
}
