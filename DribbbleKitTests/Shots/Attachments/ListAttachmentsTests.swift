//
//  ListAttachmentsTests.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/28.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import XCTest
import DribbbleKit

class ListAttachmentsTests: XCTestCase, JSONTestable {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParse() throws {
        let json = try load("ListAttachmentData")
        let req = ListAttachments<DataSet.AttachmentEntity>(id: 1)
        let response = try req.response(from: json, urlResponse: DataSet.emptyURLResponse)
        XCTAssertEqual(response.data.elements.count, 1)
    }
}
