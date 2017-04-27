//
//  Transformer.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/15.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Alter

struct Transformer {
    static let date: (String) throws -> Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return {
            guard let date = formatter.date(from: $0) else {
                throw typeMismatch(expected: Date.self, actual: $0)
            }
            return date
        }
    }()
    static let url: (String) throws -> URL = {
        guard let url = URL(string: $0) else {
            throw typeMismatch(expected: URL.self, actual: $0)
        }
        return url
    }

    private static func typeMismatch(expected: Any.Type, actual: Any) -> Error {
        return DecodeError.typeMismatch(expected: expected, actual: actual, keyPath: [])
    }

    private init() {}
}

struct ParameterTransformer {
    static let date: (Date) -> String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string
    }()

    private init() {}
}
