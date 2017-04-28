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
    case invalidScope(current: [OAuth.Scope], require: OAuth.Scope)
    case invalidOAuth(error: String, description: String)
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

    func actualError(_ meta: Meta) -> Error {
        if let errors = errors {
            return DribbbleError.invalidFields(message: message, errors: errors)
        } else if meta.status == 429 {
            return DribbbleError.rateLimit(message: message, meta: meta)
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
    func throwIfErrorOccurred(from object: Any, meta: Meta) throws {
        let code = meta.status
        if (400..<500).contains(code) && code != 404 {
            do {
                throw (try decode(object) as BaseError).actualError(meta)
            } catch let error as DribbbleError {
                throw error
            } catch {}
        }
    }
}
