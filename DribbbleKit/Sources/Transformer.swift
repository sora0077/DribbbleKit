//
//  Transformer.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/15.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import Himotoki

struct Transformer {
    static let date: (KeyPath) -> Himotoki.Transformer<String, Date> = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return { keyPath in
            Himotoki.Transformer {
                guard let date = formatter.date(from: $0) else {
                    throw typeMismatch(expected: Date.self, actual: $0, keyPath: keyPath)
                }
                return date
            }
        }
    }()
    static let url: (KeyPath) -> Himotoki.Transformer<String, URL> = { keyPath in
        Himotoki.Transformer {
            guard let url = URL(string: $0) else {
                throw typeMismatch(expected: URL.self, actual: $0, keyPath: keyPath)
            }
            return url
        }
    }

    private static func typeMismatch(expected: Any.Type, actual: Any, keyPath: KeyPath) -> Error {
        return DecodeError.typeMismatch(expected: String(describing: expected),
                                        actual: String(describing: actual),
                                        keyPath: keyPath)
    }
}

extension Extractor {
    func value<T: Decodable, R>(_ keyPath: KeyPath, _ transfomer: (KeyPath) -> Himotoki.Transformer<T, R>) throws -> R {
        return try transfomer(keyPath).apply(value(keyPath))
    }

    func valueOptional<T: Decodable, R>(_ keyPath: KeyPath, _ transfomer: (KeyPath) -> Himotoki.Transformer<T, R>) throws -> R? {
        return try valueOptional(keyPath).map { value in
            try transfomer(keyPath).apply(value)
        }
    }

    func dictionary<T: Decodable, R>(_ keyPath: KeyPath, _ transfomer: (KeyPath) -> Himotoki.Transformer<T, R>) throws -> [String: R] {
        return try transfomer(keyPath).apply(dictionary(keyPath))
    }
}
