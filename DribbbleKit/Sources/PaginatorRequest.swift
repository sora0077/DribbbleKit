//
//  PaginatorRequest.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public protocol PaginatorRequest: Request {
    associatedtype Element
    typealias Response = DribbbleKit.Response<Paginator<Self>>

    init(link: Meta.Link) throws

    func pagingRequests(from objects: [Any], meta: Meta) throws -> (prev: Self?, next: Self?)

    func responseElements(from objects: [Any], meta: Meta) throws -> [Element]
}

public struct Paginator<P: PaginatorRequest> {
    public let elements: [P.Element]
    public let prev: P?
    public let next: P?

    init(elements: [P.Element], requests: (prev: P?, next: P?)) {
        self.elements = elements
        (self.prev, self.next) = requests
    }
}

extension PaginatorRequest {
    public var scope: OAuth.Scope? { return nil }
    public var method: HTTPMethod { return .get }

    public func pagingRequests(from objects: [Any], meta: Meta) throws -> (prev: Self?, next: Self?) {
        return try (meta.link.prev.map(type(of: self).init), meta.link.next.map(type(of: self).init))
    }

    public func responseData(from object: Any, meta: Meta) throws -> Paginator<Self> {
        guard let list = object as? [Any] else {
            throw DecodeError.typeMismatch(expected: [Any].self, actual: object, keyPath: .empty)
        }
        return try Paginator(elements: responseElements(from: list, meta: meta),
                             requests: pagingRequests(from: list, meta: meta))
    }
}

extension PaginatorRequest where Element: Decodable {
    public func responseElements(from objects: [Any], meta: Meta) throws -> [Element] {
        return try decode(objects)
    }
}
