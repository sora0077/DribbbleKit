//
//  OAuth.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/15.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

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
            "scope": scopes.map { $0.rawValue }.joined(separator: "+"),
            "state": state]
        comps.queryItems = parameters.flatMap { (key, value) in
            guard let value = value else { return nil }
            return URLQueryItem(name: key, value: value)
        }
        return comps.url!
    }

    public static func parse(from callback: URL) throws -> (code: String, state: String?) {
        let comps = URLComponents(url: callback, resolvingAgainstBaseURL: true)
        var parameters: [String: String] = [:]
        for item in comps?.queryItems ?? [] {
            if let value = item.value {
                parameters[item.name] = value
            }
        }
        guard let code = parameters["code"] else {
            throw DribbbleError.invalidOAuth(
                error: parameters["error"] ?? "", description: parameters["error_description"] ?? "")
        }
        return (code, parameters["state"])
    }

    public struct GetToken: Request {
        public var scope: OAuth.Scope? { return nil }
        public var method: HTTPMethod { return .post }
        public var baseURL: URL { return URL(string: "https://dribbble.com")! }
        public var version: String? { return nil }
        public var path: String { return "/oauth/token" }

        public var parameters: Any? {
            return [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code,
                "redirect_uri": redirectURL?.absoluteString].cleaned
        }

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

        public func responseData(from object: Any, meta: Meta) throws -> Authorization {
            return try decode(object)
        }
    }
}
