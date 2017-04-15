//
//  OAuthAuthorize.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/15.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit

public struct OAuthAuthorize: APIKit.Request {
    public struct Response {}
    public enum Scope: String {
        case `public`, write, comment, upload
    }

    public var method: HTTPMethod { return .get }
    public var baseURL: URL { return URL(string: "https://dribbble.com")! }
    public var path: String { return "/oauth/authorize" }

    private let clientId: String
    private let redirectURL: URL
    private let scopes: [Scope]
    private let state: String?

    public init(clientId: String, redirectURL: URL, scopes: [Scope], state: String? = nil) {
        self.clientId = clientId
        self.redirectURL = redirectURL
        self.scopes = scopes
        self.state = state
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return Response()
    }
}

struct ShippingOptions: OptionSet {
    let rawValue: Int

    static let nextDay    = ShippingOptions(rawValue: 1 << 0)
    static let secondDay  = ShippingOptions(rawValue: 1 << 1)
    static let priority   = ShippingOptions(rawValue: 1 << 2)
    static let standard   = ShippingOptions(rawValue: 1 << 3)

    static let express: ShippingOptions = [.nextDay, .secondDay]
    static let all: ShippingOptions = [.express, .priority, .standard]
}
