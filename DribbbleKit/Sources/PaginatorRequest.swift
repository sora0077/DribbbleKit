//
//  PaginatorRequest.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit

public protocol PaginatorRequest: Request {
    associatedtype Element
    typealias Response = DribbbleKit.Response<Paginator<Self>>
    
    init(_ response: [String: String]) throws
    
    func pagingRequest(from object: Any, urlResponse: HTTPURLResponse) throws -> (prev: Self?, next: Self?)

    func responseElement(from objects: [Any], urlResponse: HTTPURLResponse) throws -> [Element]
}

public struct Paginator<P: PaginatorRequest> {
    public let elements: [P.Element]
    public var prev: P? = nil
    public var next: P? = nil
    
    init(_ elements: [P.Element]) {
        self.elements = elements
    }
}

extension PaginatorRequest {
    public var method: HTTPMethod { return .get }
    
    func pagingRequest(from object: Any, urlResponse: HTTPURLResponse) throws -> (prev: Self?, next: Self?) {
        guard let link = urlResponse.allHeaderFields["Link"] as? String else {
            return (nil, nil)
        }
        let links = try Link.from(string: link)
        let map = [
            Link.Rel.prev: links.first(where: { $0.rel == .prev }),
            Link.Rel.next: links.first(where: { $0.rel == .next })]
        fatalError()
    }
    
    public func responseData(from object: Any, urlResponse: HTTPURLResponse) throws -> Paginator<Self> {
        return try Paginator(responseElement(from: object as? [Any] ?? [], urlResponse: urlResponse))
    }
}


private struct Link {
    enum Rel: String {
        case prev, next
    }
    let rel: Rel
    let url: URL
    
    static func from(string: String) throws -> [Link] {
        let pairs = string.components(separatedBy: ",")
        return try pairs.map { pair in
            let urlAndRel = pairs[0].components(separatedBy: ";")
            var urlString = urlAndRel[0]
            let relString = urlAndRel[1]
            urlString = urlString
                .substring(to: urlString.index(urlString.endIndex, offsetBy: -1))
                .substring(from: urlString.index(urlString.startIndex, offsetBy: 1))
            let keyValue = relString.replacingOccurrences(of: "\"", with: "").components(separatedBy: "=")
            
            guard let url = URL(string: urlString),
                let rel = keyValue.last.flatMap(Rel.init(rawValue:)),
                keyValue.first == "rel" else {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
            return Link(rel: rel, url: url)
        }
    }
}
