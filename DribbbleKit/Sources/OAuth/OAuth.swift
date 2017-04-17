//
//  OAuth.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/15.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct OAuth {
    public enum Scope: String {
        case `public`, write, comment, upload
    }

    public static func authorizeURL(
        clientId: String,
        redirectURL: URL? = nil,
        scopes: [Scope],
        state: String? = nil) -> URL {
        var comps = URLComponents(string: "https://dribbble.com/oauth/authorize")!
        let parameters = [
            "client_id": clientId,
            "redirect_uri": redirectURL?.absoluteString,
            "scope": scopes.map { $0.rawValue }.joined(separator: " "),
            "state": state]
        comps.queryItems = parameters.flatMap { (key, value) in
            guard let value = value else { return nil }
            return URLQueryItem(name: key, value: value)
        }
        return comps.url!
    }

    public struct GetToken: APIKit.Request {
        public struct Response {
            public let accessToken: String
            public let tokenType: String
            public let scopes: [OAuth.Scope]
        }
        public var method: HTTPMethod { return .post }
        public var baseURL: URL { return URL(string: "https://dribbble.com")! }
        public var path: String { return "/oauth/token" }

        private let clientId: String
        private let clientSecret: String
        private let code: String
        private let redirectURL: URL?

        public init(clientId: String, clientSecret: String, code: String, redirectURL: URL? = nil) {
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.code = code
            self.redirectURL = redirectURL
        }

        public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> GetToken.Response {
            return try decodeValue(object)
        }
    }
}

extension OAuth.GetToken.Response: Decodable {
    public static func decode(_ e: Extractor) throws -> OAuth.GetToken.Response {
        let scope: String = try e.value("scope")
        return try self.init(
            accessToken: e.value("access_token"),
            tokenType: e.value("token_type"),
            scopes: scope.components(separatedBy: " ").flatMap(OAuth.Scope.init(rawValue:)))
    }
}
