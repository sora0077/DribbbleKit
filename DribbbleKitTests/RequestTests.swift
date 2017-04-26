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
}
