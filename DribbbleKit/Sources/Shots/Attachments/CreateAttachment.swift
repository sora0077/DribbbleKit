//
//  CreateAttachment.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct CreateAttachment: PostRequest {
    public typealias Response = DribbbleKit.Response<Attachment.Identifier>

    public var path: String { return "/shots/\(id.value)/attachments" }
    private let id: Shot.Identifier
    public var data: Data

    public init(id: Shot.Identifier, data: Data) {
        self.id = id
        self.data = data
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        let meta = Meta(urlResponse: urlResponse)
        guard let location = meta["Location"] as? String,
            let id = location.components(separatedBy: "/").last.flatMap({ Int($0) }) else {
                throw DribbbleError.unexpected
        }
        return Response(meta: meta, data: Attachment.Identifier(integerLiteral: id))
    }
}
