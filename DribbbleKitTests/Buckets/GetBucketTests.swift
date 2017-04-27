//
//  GetBucketTests.swift
//  DribbbleKit
//
//  Created by 林達也 on 2017/04/28.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import XCTest
import DribbbleKit

class GetBucketTests: XCTestCase, JSONTestable {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParse() {
        do {
            let json = try load("BucketData")
            let req = GetBucket<DataSet.BucketEntity, DataSet.UserEntity>(id: 1)
            _ = try req.response(from: json, urlResponse: DataSet.emptyURLResponse)
            XCTAssert(true)
        } catch {
            XCTFail("\(error)")
        }
    }
}
