//
//  Response.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/24.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct Response<Data> {
    public let meta: Meta
    public let data: Data
}

public final class Meta {
    public struct RateLimit {
        var limit: Int
        var remaining: Int
        var reset: Int
    }
    public struct Link {
        public let url: URL

        var queries: [String: String] {
            let comps = URLComponents(url: url, resolvingAgainstBaseURL: true)
            var result: [String: String] = [:]
            comps?.queryItems?.forEach {
                if let value = $0.value {
                    result[$0.name] = value
                }
            }
            return result
        }
    }
    private(set) lazy var link: (prev: Link?, next: Link?) = self.parseLinks()
    private let urlResponse: HTTPURLResponse
    private var headers: [AnyHashable: Any] { return urlResponse.allHeaderFields }

    public private(set) lazy var rateLimit: RateLimit = {
        RateLimit(limit: self.headers[intValueForKey: "X-RateLimit-Limit"],
                  remaining: self.headers[intValueForKey: "X-RateLimit-Remaining"],
                  reset: self.headers[intValueForKey: "X-RateLimit-Reset"])
    }()

    public subscript (_ key: AnyHashable) -> Any? {
        return urlResponse.allHeaderFields[key]
    }

    init(_ urlResponse: HTTPURLResponse) {
        self.urlResponse = urlResponse
    }

    private func parseLinks() -> (prev: Link?, next: Link?) {
        func parse(_ urlAndRel: [String]) -> (rel: String, link: Link)? {
            var urlString = urlAndRel[0]
            let relString = urlAndRel[1]
            urlString = urlString
                .substring(to: urlString.index(urlString.endIndex, offsetBy: -1))
                .substring(from: urlString.index(urlString.startIndex, offsetBy: 1))
            let keyValue = relString.replacingOccurrences(of: "\"", with: "").components(separatedBy: "=")
            guard let url = URL(string: urlString), let rel = keyValue.last, keyValue.first == "rel" else {
                return nil
            }
            return (rel, Link(url: url))
        }

        guard let string = self["Link"] as? String else { return (nil, nil) }
        let pairs = string.components(separatedBy: ",")
        let links = pairs.flatMap { parse($0.components(separatedBy: ";")) }
        let map = [
            "prev": links.first(where: { $0.rel == "prev" })?.link,
            "next": links.first(where: { $0.rel == "next" })?.link]
        return (map["prev"] ?? nil, map["next"] ?? nil)
    }
}

private extension Dictionary where Key == AnyHashable, Value == Any {
    subscript (intValueForKey key: Key) -> Int {
        return  self[key] as? Int ?? 0
    }
}
