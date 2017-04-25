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

    func testParseShotData() {
        struct ShotEntity: ShotData {
            init(id: Shot.Identifier,
                 title: String,
                 description: String,
                 width: Int,
                 height: Int,
                 images: [String : URL],
                 viewsCount: Int,
                 likesCount: Int,
                 commentsCount: Int,
                 attachmentsCount: Int,
                 reboundsCount: Int,
                 bucketsCount: Int,
                 createdAt: Date,
                 updatedAt: Date,
                 htmlURL: URL,
                 attachmentsURL: URL,
                 bucketsURL: URL,
                 commentsURL: URL,
                 likesURL: URL,
                 projectsURL: URL,
                 reboundsURL: URL,
                 animated: Bool,
                 tags: [String]
            ) throws {

            }
        }
        do {
            let json = try load("ShotData")
            let _: ShotEntity = try decode(json)
        } catch {
            XCTFail("\(error)")
        }
    }

}
