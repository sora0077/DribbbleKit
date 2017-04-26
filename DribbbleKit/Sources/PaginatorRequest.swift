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

    func pagingRequest(from object: Any, meta: Meta) throws -> (prev: Self?, next: Self?)

    func responseElements(from objects: [Any], meta: Meta) throws -> [Element]
}

public struct Paginator<P: PaginatorRequest> {
    public let elements: [P.Element]
    public let prev: P?
    public let next: P?

    init(_ elements: [P.Element], prev: P?, next: P?) {
        self.elements = elements
        self.prev = prev
        self.next = next
    }
}

extension PaginatorRequest {
    public var method: HTTPMethod { return .get }

    public func pagingRequest(from object: Any, meta: Meta) throws -> (prev: Self?, next: Self?) {
        return try (meta.link.prev.map(type(of: self).init), meta.link.next.map(type(of: self).init))
    }

    public func responseData(from object: Any, urlResponse: HTTPURLResponse) throws -> Paginator<Self> {
        guard let list = object as? [Any] else {
            throw DecodeError.typeMismatch(expected: [Any].self, actual: object, keyPath: .empty)
        }
        let meta = Meta(urlResponse)
        let elements = try responseElements(from: list, meta: meta)
        let (prev, next) = try pagingRequest(from: object, meta: meta)
        return Paginator(elements, prev: prev, next: next)
    }
}
