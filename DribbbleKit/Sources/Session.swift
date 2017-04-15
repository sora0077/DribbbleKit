//
//  Session.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit
import Result

open class Session: APIKit.Session {

    public var authorization: Authorization?

    open override func send<Request>(
        _ request: Request,
        callbackQueue: CallbackQueue? = nil,
        handler: @escaping (Result<Request.Response, SessionTaskError>) -> Void)
        -> SessionTask? where Request : DribbbleKit.Request {
        return super.send(request, callbackQueue: callbackQueue, handler: handler)
    }
}
