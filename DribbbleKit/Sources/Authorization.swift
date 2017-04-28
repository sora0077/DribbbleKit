//
//  Authorization.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/15.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

public struct Authorization {
    public let accessToken: String
    public let tokenType: String
    public let scopes: [OAuth.Scope]

    public func encode() -> [String: Any] {
        return [
            "access_token": accessToken,
            "token_type": tokenType,
            "scope": scopes.map { $0.rawValue }.joined(separator: " ")]
    }
}

extension Authorization: Decodable {
    public static func decode(_ decoder: Decoder) throws -> Authorization {
        do {
            let scope: String = try decoder.decode(forKeyPath: "scope")
            return try self.init(
                accessToken: decoder.decode(forKeyPath: "access_token"),
                tokenType: decoder.decode(forKeyPath: "token_type"),
                scopes: scope.components(separatedBy: " ").flatMap(OAuth.Scope.init(rawValue:)))
        } catch let modelError {
            do {
                throw DribbbleError.invalidOAuth(error: try decoder.decode(forKeyPath: "error"),
                                                 description: try decoder.decode(forKeyPath: "error_description"))
            } catch {
                switch error {
                case DribbbleError.invalidOAuth: throw error
                default: throw modelError
                }
            }
        }
    }
}
