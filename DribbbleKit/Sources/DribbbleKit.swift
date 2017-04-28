//
//  DribbbleKit.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation

public struct Configuration {
    public var perPage: Int?
    public var baseURL: URL?

    public init(perPage: Int? = nil, baseURL: URL? = nil) {
        self.perPage = perPage
        self.baseURL = baseURL
    }
}

private(set) var configuration: Configuration?

public func setup(_ config: Configuration) {
    configuration = config
}

// MARK: - helper
extension Dictionary where Value == Any? {
    var cleaned: [Key: Any] {
        // swiftlint:disable:next syntactic_sugar
        var dict = Dictionary<Key, Any>(minimumCapacity: count)
        for (k, v) in self {
            if let value = v {
                dict[k] = value
            }
        }
        return dict
    }
}
