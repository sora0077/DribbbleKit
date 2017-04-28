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

private struct AnyRequest<R>: APIKit.Request {
    typealias Response = R

    let method: HTTPMethod
    let baseURL: URL
    let path: String

    let headerFields: [String : String]
    let parameters: Any?

    private let response: (Any, HTTPURLResponse) throws -> R
    fileprivate let raw: Any

    init<Req: APIKit.Request>(_ request: Req, authorization: Authorization?) where Req.Response == R {
        method = request.method
        baseURL = request.baseURL
        path = request.path
        parameters = request.parameters
        response = request.response
        raw = request

        var headers = request.headerFields
        if let authorization = authorization {
            headers["Authorization"] = "Bearer \(authorization.accessToken)"
        }
        headerFields = headers
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> R {
        return try response(object, urlResponse)
    }
}

public class Session: APIKit.Session {

    public override class var shared: Session { return _shared }
    private static let _shared = Session(adapter: URLSessionAdapter(configuration: URLSessionConfiguration.default))

    public var authorization: Authorization?

    public override func send<Request>(
        _ request: Request,
        callbackQueue: CallbackQueue? = nil,
        handler: @escaping (Result<Request.Response, SessionTaskError>) -> Void)
        -> SessionTask? where Request : DribbbleKit.Request {
            let scopes = authorization?.scopes ?? []
            if let scope = request.scope, !scopes.contains(scope) {
                (callbackQueue ?? CallbackQueue.main).execute {
                    let error = DribbbleError.invalidScope(current: scopes, require: scope)
                    handler(Result(error: SessionTaskError.requestError(error)))
                }
                return nil
            }
            return super.send(AnyRequest(request, authorization: authorization),
                              callbackQueue: callbackQueue,
                              handler: handler)
    }

    public override func cancelRequests<Request>(
        with requestType: Request.Type,
        passingTest test: @escaping (Request) -> Bool)
        where Request : APIKit.Request {
            super.cancelRequests(with: AnyRequest<Request.Response>.self) { request in
                guard let raw = request.raw as? Request else {
                    return false
                }
                return test(raw)
            }
    }
}
