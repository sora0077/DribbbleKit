//
//  DribbbleKit.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public enum DribbbleError: Swift.Error {
    public struct Error {
        public let attribute: String
        public let message: String
    }
    case invalidJSON(message: String)
    case invalidFields(message: String, errors: [Error])
    case rateLimit(message: String, meta: Meta)
    case unexpected
}

extension DribbbleError.Error: Decodable {
    public static func decode(_ decoder: Decoder) throws -> DribbbleError.Error {
        return try self.init(
            attribute: decoder.decode(forKeyPath: "attribute"),
            message: decoder.decode(forKeyPath: "message"))
    }
}
