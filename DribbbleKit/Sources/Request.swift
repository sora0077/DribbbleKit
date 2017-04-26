//
//  Request.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/24.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public protocol Request: APIKit.Request {
    associatedtype Data
    typealias Response = DribbbleKit.Response<Data>
}

extension Request {
    public var baseURL: URL { return URL(string: "https://api.dribbble.com")! }

    public func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        switch urlResponse.statusCode {
        case 400..<500 where urlResponse.statusCode != 404:
            let message: String = try decode(object)
            let errors: [DribbbleError.Error]? = try decode(object, rootKeyPath: "errors", optional: true)
            if let errors = errors {
                throw DribbbleError.invalidFields(message: message, errors: errors)
            } else {
                throw DribbbleError.invalidJSON(message: message)
            }
        default:
            return object
        }
    }
}
extension Request where Data: Decodable {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> DribbbleKit.Response<Data> {
        return try DribbbleKit.Response(meta: Meta(urlResponse), data: decode(object))
    }
}

public protocol GetRequest: Request {}
public protocol PostRequest: Request {}
public protocol PutRequest: Request {}
public protocol DeleteRequest: Request {}
public protocol ListRequest: GetRequest {
    func response(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Self.Response
}

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

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> DribbbleKit.Response<Void> {
        return DribbbleKit.Response(meta: Meta(urlResponse), data: ())
    }
}
extension ListRequest {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        guard let list = object as? [Any] else {
            throw DecodeError.typeMismatch(expected: [Any].self, actual: object, keyPath: [])
        }
        return try response(from: list, urlResponse: urlResponse)
    }
}
