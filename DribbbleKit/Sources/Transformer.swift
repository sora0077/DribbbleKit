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
                    throw DecodeError.typeMismatch(expected: "Date", actual: $0, keyPath: keyPath)
                }
                return date
            }
        }
    }()
    static let url: (KeyPath) -> Himotoki.Transformer<String, URL> = { keyPath in
        Himotoki.Transformer {
            guard let url = URL(string: $0) else {
                throw DecodeError.typeMismatch(expected: "URL", actual: $0, keyPath: keyPath)
            }
            return url
        }
    }
}

extension Extractor {
    func value<T: Decodable, R>(_ keyPath: KeyPath, _ transfomer: (KeyPath) -> Himotoki.Transformer<T, R>) throws -> R {
        return try transfomer(keyPath).apply(value(keyPath))
    }

    func valueOptional<T: Decodable, R>(
        _ keyPath: KeyPath,
        transfomer: (KeyPath) -> Himotoki.Transformer<T, R>)
        throws -> R? {
        return try valueOptional(keyPath).map { value in
            try transfomer(keyPath).apply(value)
        }
    }
}
