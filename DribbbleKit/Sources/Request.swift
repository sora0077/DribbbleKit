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

    func responseData(from object: Any, urlResponse: HTTPURLResponse) throws -> Data
}

extension Request {
    public var baseURL: URL { return URL(string: "https://api.dribbble.com")! }

    public func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        try throwIfErrorOccurred(from: object, urlResponse: urlResponse)
        return object
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> DribbbleKit.Response<Data> {
        return try DribbbleKit.Response(meta: Meta(urlResponse), data: responseData(from: object, urlResponse: urlResponse))
    }
}
extension Request where Data: Decodable {
    public func responseData(from object: Any, urlResponse: HTTPURLResponse) throws -> Data {
        return try decode(object)
    }
}

public protocol GetRequest: Request {}
public protocol PostRequest: Request {}
public protocol PutRequest: Request {}
public protocol DeleteRequest: Request {}
public protocol ListRequest: GetRequest {
    func responseData(from objects: [Any], urlResponse: HTTPURLResponse) throws -> Data
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

    public func responseData(from object: Any, urlResponse: HTTPURLResponse) throws {
        return
    }
}
extension ListRequest {
    public func responseData(from object: Any, urlResponse: HTTPURLResponse) throws -> Data {
        guard let list = object as? [Any] else {
            throw DecodeError.typeMismatch(expected: [Any].self, actual: object, keyPath: [])
        }
        return try responseData(from: list, urlResponse: urlResponse)
    }
}
