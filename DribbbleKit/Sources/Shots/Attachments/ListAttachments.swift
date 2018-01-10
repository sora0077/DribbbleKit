//
//  ListAttachments.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct ListAttachments<Data: AttachmentData>: PaginatorRequest {
    public typealias Element = Data

    public let path: String
    public let parameters: Any?

    public init(id: Shot.Identifier, page: Int? = nil, perPage: Int? = configuration?.perPage) {
        path = "/shots/\(id.value)/attachments"
        parameters = [
            "page": page,
            "per_page": perPage].cleaned
    }

    public init(path: String, parameters: [String: Any]) throws {
        self.path = path
        self.parameters = parameters
    }
}
