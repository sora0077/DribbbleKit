//
//  DeleteAttachment.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/20.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

public struct DeleteAttachment: DeleteRequest {
    public typealias Response = DribbbleKit.Response<Void>

    public var path: String { return "/shots/\(shotId)/attachments/\(id.value)" }
    private let shotId: Shot.Identifier
    private let id: Attachment.Identifier

    public init(shotId: Shot.Identifier, id: Attachment.Identifier) {
        self.shotId = shotId
        self.id = id
    }
}
