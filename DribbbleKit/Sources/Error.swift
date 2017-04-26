//
//  Error.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
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

private struct BaseError: Decodable {
    let message: String
    let errors: [DribbbleError.Error]?

    func actualError(_ urlResponse: HTTPURLResponse) -> Error {
        if let errors = errors {
            return DribbbleError.invalidFields(message: message, errors: errors)
        } else if urlResponse.statusCode == 429 {
            return DribbbleError.rateLimit(message: message, meta: Meta(urlResponse))
        } else {
            return DribbbleError.invalidJSON(message: message)
        }
    }

    static func decode(_ decoder: Decoder) throws -> BaseError {
        return try self.init(
            message: decoder.decode(forKeyPath: "message"),
            errors: decoder.decode(forKeyPath: "errors", optional: true))
    }
}

extension Request {
    func throwIfErrorOccurred(from object: Any, urlResponse: HTTPURLResponse) throws {
        let code = urlResponse.statusCode
        if (400..<500).contains(code) && code != 404 {
            throw (try decode(object) as BaseError).actualError(urlResponse)
        }
    }
}
