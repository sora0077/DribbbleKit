//
//  ShotsTests.swift
//  DribbbleKit
//
//  Created by 林 達也 on 2017/04/25.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import XCTest
import DribbbleKit
import Alter

class ShotsTests: XCTestCase, JSONTestable {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParseShotData() throws {
        let json = try load("ShotData")
        let _: DataSet.ShotEntity = try decode(json)
    }

    func testGetShot() throws {
        let json = try load("ShotData")
        let req = GetShot<DataSet.ShotEntity, DataSet.UserEntity>(id: 1)
        _ = try req.response(from: json, urlResponse: DataSet.emptyURLResponse)
    }
}
