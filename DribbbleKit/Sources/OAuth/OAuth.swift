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
    public enum Error: Swift.Error {
        case unknown
        case invalid(error: String, description: String)
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
            if let error = parameters["error"] {
                throw Error.invalid(error: error, description: parameters["error_description"] ?? "")
            }
            throw Error.unknown
        }
        return (code, parameters["state"])
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
        do {
            let scope: String = try e.value("scope")
            return try self.init(
                accessToken: e.value("access_token"),
                tokenType: e.value("token_type"),
                scopes: scope.components(separatedBy: " ").flatMap(OAuth.Scope.init(rawValue:)))
        } catch let modelError {
            do {
                throw OAuth.Error.invalid(error: try e.value("error"),
                                          description: try e.value("error_description"))
            } catch let error as OAuth.Error {
                throw error
            } catch {
                throw modelError
            }
        }
    }
}
