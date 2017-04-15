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
    static let stringToDate: Himotoki.Transformer<String, Date> = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return Himotoki.Transformer {
            guard let date = formatter.date(from: $0) else {
                throw DecodeError.typeMismatch(expected: "Date", actual: $0, keyPath: "")
            }
            return date
        }
    }()
}
