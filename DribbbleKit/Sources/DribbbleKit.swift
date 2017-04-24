//
//  DribbbleKit.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public enum DribbbleError: Swift.Error {
    public struct Error {
        public let attribute: String
        public let message: String
    }
    case invalidJSON(message: String)
    case invalidFields(message: String, errors: [Error])
    case unexpected
}

func optional<T: Decodable>(_ f: @autoclosure () throws -> T, if cond: (_ missingKeyPath: KeyPath) -> Bool) rethrows -> T? {
    do {
        return try f()
    } catch let DecodeError.missingKeyPath(keyPath) where cond(keyPath) {
        return nil
    }
}
