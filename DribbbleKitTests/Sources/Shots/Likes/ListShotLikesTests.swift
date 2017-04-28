//
//  ListShotLikesTests.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/27.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import XCTest
import DribbbleKit

class ListShotLikesTests: XCTestCase, JSONTestable {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPagination() throws {
        let json = try load("ListLikeData")
        let request = ListShotLikes<DataSet.LikeEntity, DataSet.UserEntity>(id: 1)
        do {
            let urlResponse = DataSet.linkURLResponse(
                prev: URL(string: "https://api.dribbble.com/v1/user/followers?page=1&per_page=100"),
                next: URL(string: "https://api.dribbble.com/v1/user/followers?page=3&per_page=100"))
            let response = try request.response(from: json, urlResponse: urlResponse)
            XCTAssertNotNil(response.data.prev)
            XCTAssertNotNil(response.data.next)
            XCTAssertEqual(response.data.prev?.path, "/v1/user/followers")
            XCTAssertEqual(response.data.next?.path, "/v1/user/followers")
            XCTAssertEqual((response.data.prev?.parameters as? [String: Any])?["page"] as? String, "1")
            XCTAssertEqual((response.data.prev?.parameters as? [String: Any])?["per_page"] as? String, "100")
            XCTAssertEqual((response.data.next?.parameters as? [String: Any])?["page"] as? String, "3")
            XCTAssertEqual((response.data.next?.parameters as? [String: Any])?["per_page"] as? String, "100")
            XCTAssertEqual(response.data.elements.count, 1)
        } catch {
            XCTFail("\(error)")
        }
    }
}
