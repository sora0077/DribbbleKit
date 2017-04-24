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
extension GetRequest where Data: Decodable {
    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> DribbbleKit.Response<Data> {
        return try DribbbleKit.Response(meta: Meta(urlResponse: urlResponse), data: decode(object))
    }
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
        return DribbbleKit.Response(meta: Meta(urlResponse: urlResponse), data: ())
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
