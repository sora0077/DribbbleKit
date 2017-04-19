//
//  DribbbleKit.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public protocol Request: APIKit.Request {
    associatedtype Data
    typealias Response = DribbbleKit.Response<Data>
}

public protocol GetRequest: Request {}
public protocol PostRequest: Request {}
public protocol PutRequest: Request {}
public protocol DeleteRequest: Request {}

extension GetRequest {
    public var method: HTTPMethod { return .get }
}
extension PostRequest {
    public var method: HTTPMethod { return .post }
}
extension PutRequest {
    public var method: HTTPMethod { return .put }
}
extension DeleteRequest {
    public var method: HTTPMethod { return .delete }
}

public final class Meta {
    private let urlResponse: HTTPURLResponse
    private var headers: [AnyHashable: Any] { return urlResponse.allHeaderFields }

    public private(set) lazy var rateLimit: RateLimit = {
        RateLimit(limit: self.headers[intValueForKey: "X-RateLimit-Limit"],
                  remaining: self.headers[intValueForKey: "X-RateLimit-Remaining"],
                  reset: self.headers[intValueForKey: "X-RateLimit-Reset"])
    }()

    subscript (_ key: AnyHashable) -> Any? {
        return urlResponse.allHeaderFields[key]
    }

    init(urlResponse: HTTPURLResponse) {
        self.urlResponse = urlResponse
    }
}

public struct Response<Data> {
    public let meta: Meta
    public let data: Data
}

public struct RateLimit {
    var limit: Int
    var remaining: Int
    var reset: Int
}

public enum DribbbleError: Swift.Error {
    public struct Error {
        public let attribute: String
        public let message: String
    }
    case invalidJSON(message: String)
    case invalidFields(message: String, errors: [Error])
    case unexpected
}

extension Request {
    public var baseURL: URL { return URL(string: "https://api.dribbble.com")! }
}

private extension Dictionary where Key == AnyHashable, Value == Any {
    subscript (intValueForKey key: Key) -> Int {
        return  self[key] as? Int ?? 0
    }
}
