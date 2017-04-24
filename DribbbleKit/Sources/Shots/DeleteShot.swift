//
//  DeleteShot.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/19.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct DeleteShot: DeleteRequest {
    public typealias Response = DribbbleKit.Response<Void>

    public var path: String { return "/shots/\(id.value)" }
    private let id: Shot.Identifier

    public init(id: Shot.Identifier) {
        self.id = id
    }
}
