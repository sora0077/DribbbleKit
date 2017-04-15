//
//  OAuthToken.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/15.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct OAuthToken: APIKit.Request {
    public struct Response {
        public let accessToken: String
        public let tokenType: String
        public let scopes: [OAuthAuthorize.Scope]
    }
    public var method: HTTPMethod { return .post }
    public var baseURL: URL { return URL(string: "https://dribbble.com")! }
    public var path: String { return "/oauth/token" }

    private let clientId: String
    private let clientSecret: String
    private let code: String
    private let redirectURL: URL

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> OAuthToken.Response {
        return try decodeValue(object)
    }
}

extension OAuthToken.Response: Decodable {
    public static func decode(_ e: Extractor) throws -> OAuthToken.Response {
        let scope: String = try e.value("scope")
        return try self.init(
            accessToken: e.value("access_token"),
            tokenType: e.value("token_type"),
            scopes: scope.components(separatedBy: " ").flatMap(OAuthAuthorize.Scope.init(rawValue:)))
    }
}
