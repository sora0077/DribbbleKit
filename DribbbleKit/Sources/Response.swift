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
}

private extension Dictionary where Key == AnyHashable, Value == Any {
    subscript (intValueForKey key: Key) -> Int {
        return  self[key] as? Int ?? 0
    }
}
