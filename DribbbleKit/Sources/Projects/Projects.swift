//
//  Projects.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/25.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct Project {
    public struct Identifier: Decodable, ExpressibleByIntegerLiteral {
        let value: Int
        public init(integerLiteral value: Int) {
            self.value = value
        }

        public init(_ value: Int) {
            self.value = value
        }

        public static func decode(_ decoder: Decoder) throws -> Project.Identifier {
            return try self.init(integerLiteral: Int.decode(decoder))
        }
    }
}

extension Int {
    public init(_ projectId: Project.Identifier) {
        self = projectId.value
    }
}

public protocol ProjectData: Decodable {
    typealias Identifier = Project.Identifier
    init(
        id: Project.Identifier,
        name: String,
        description: String,
        shotsCount: Int,
        createdAt: Date,
        updatedAt: Date
    ) throws
}

extension ProjectData {
    public static func decode(_ decoder: Decoder) throws -> Self {
        return try self.init(
            id: decoder.decode(forKeyPath: "id"),
            name: decoder.decode(forKeyPath: "name"),
            description: decoder.decode(forKeyPath: "description"),
            shotsCount: decoder.decode(forKeyPath: "shots_count"),
            createdAt: decoder.decode(forKeyPath: "created_at", Transformer.date),
            updatedAt: decoder.decode(forKeyPath: "updated_at", Transformer.date))
    }
}
