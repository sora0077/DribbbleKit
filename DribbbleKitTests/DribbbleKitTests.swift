//
//  DribbbleKitTests.swift
//  DribbbleKitTests
//
//  Created by 林達也 on 2017/04/14.
//  Copyright © 2017年 jp.sora0077. All rights reserved.
//

import XCTest
@testable import DribbbleKit

protocol JSONTestable {
    func load(_ filename: String) throws -> Data
}

extension JSONTestable {
    func load(_ filename: String) throws -> Data {
        let bundle = Bundle(for: DribbbleKitTests.self)
        guard let path = bundle.path(forResource: filename, ofType: "json") else {
            return Data()
        }
        let string = try String(contentsOfFile: path)
        return string.data(using: .utf8) ?? Data()
    }
}

class DribbbleKitTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
