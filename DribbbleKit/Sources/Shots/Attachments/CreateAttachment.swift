//
//  CreateAttachment.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Alter

public struct CreateAttachment: PostRequest {
    public typealias Response = DribbbleKit.Response<Attachment.Identifier>

    public var scope: OAuth.Scope? { return .upload }
    public var path: String { return "/shots/\(id.value)/attachments" }
    public var bodyParameters: BodyParameters? {
        return MultipartFormDataBodyParameters(parts: [
            MultipartFormDataBodyParameters.Part(data: data, name: "file")])
    }

    private let id: Shot.Identifier
    public var data: Data

    public init(id: Shot.Identifier, data: Data) {
        self.id = id
        self.data = data
    }

    public func responseData(from object: Any, urlResponse: HTTPURLResponse) throws -> Attachment.Identifier {
        guard let location = urlResponse.allHeaderFields["Location"] as? String,
            let id = location.components(separatedBy: "/").last.flatMap({ Int($0) }) else {
                throw DribbbleError.unexpected
        }
        return Attachment.Identifier(integerLiteral: id)
    }
}
