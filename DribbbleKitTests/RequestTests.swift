//
//  RequestTests.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/26.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import XCTest
import DribbbleKit

class RequestTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInvalidJSONErrorResponse() {
        let json = [
            "message": "Problem parsing JSON."
        ]
        let request = GetUser<DataSet.UserEntity>(username: "hoge")
        do {
            _ = try request.intercept(object: json, urlResponse: DataSet.badRequestURLResponse)
        } catch DribbbleError.invalidJSON(let message) {
            XCTAssertEqual(message, json["message"])
        } catch {
            XCTFail("\(error)")
        }
    }

    func testInvalidFieldsErrorResponse() {
        let json: [String: Any] = [
            "message": "Problem parsing JSON.",
            "errors": [
                ["attribute": "body",
                 "message": "can't be blank"]
            ]
        ]
        let request = GetUser<DataSet.UserEntity>(username: "hoge")
        do {
            _ = try request.intercept(object: json, urlResponse: DataSet.badRequestURLResponse)
        } catch DribbbleError.invalidFields(let message, let errors) {
            XCTAssertEqual(message, json["message"] as? String)
            XCTAssertEqual(errors[0].attribute, "body")
        } catch {
            XCTFail("\(error)")
        }
    }

    func testRateLimitErrorResponse() {
        let json = [
            "message": "Rate limit"
        ]
        let request = GetUser<DataSet.UserEntity>(username: "hoge")
        do {
            _ = try request.intercept(object: json, urlResponse: DataSet.rateLimitURLResponse())
        } catch let DribbbleError.rateLimit(message, _) {
            XCTAssertEqual(message, json["message"])
        } catch {
            XCTFail("\(error)")
        }
    }

    func testNoErrorResponse() {
        let json: [String: Any] = [
            "id": 24400091,
            "created_at": "2014-01-06T17:19:59Z"
        ]
        let request = GetLike<DataSet.LikeEntity>(id: 1)
        do {
            let urlResponse = DataSet.validURLResponse()
            _ = try request.intercept(object: json, urlResponse: urlResponse)
            let like = try request.response(from: json, urlResponse: urlResponse)
            XCTAssertEqual(like.data?.id, 24400091)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testNotFoundResponse() {
        let json: [String: Any] = [:]
        let request = GetLike<DataSet.LikeEntity>(id: 1)
        do {
            let urlResponse = DataSet.notFoundURLResponse
            _ = try request.intercept(object: json, urlResponse: urlResponse)
            let like = try request.response(from: json, urlResponse: urlResponse)
            XCTAssertNil(like.data)
        } catch {
            XCTFail("\(error)")
        }
    }
}
