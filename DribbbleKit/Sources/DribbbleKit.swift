//
//  DribbbleKit.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation

protocol OptionalType {
    associatedtype WrappedType

    var value: WrappedType? { get }
}

extension Optional: OptionalType {
    typealias WrappedType = Wrapped

    var value: Wrapped? {
        switch self {
        case .some(let value): return value
        case .none: return nil
        }
    }
}

extension Dictionary where Value: OptionalType {
    var cleaned: [Key: Value.WrappedType] {
        // swiftlint:disable:next syntactic_sugar
        var dict = Dictionary<Key, Value.WrappedType>(minimumCapacity: count)
        for (k, v) in self {
            if let value = v.value {
                dict[k] = value
            }
        }
        return dict
    }
}
