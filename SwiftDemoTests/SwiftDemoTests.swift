//
//  SwiftDemoTests.swift
//  SwiftDemoTests
//
//  Created by Ryan Han on 7/24/17.
//  Copyright © 2017 Surfline. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import SwiftDemo

class SwiftDemoTests: XCTestCase {
    let timeout: TimeInterval = 15
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMusic() {
        stub(condition: { (req) -> Bool in
            return true
        }) { (req) -> OHHTTPStubsResponse in
            let path = Bundle.main.path(forResource: "music-200", ofType: "json")!
            return fixture(filePath: path, status: 200, headers: [:])
        }
        
        let arrived = self.expectation(description: #function)
        
        MusicModel.requestMusic(term: "someone") { (error, musics) in
            //do test
            
            arrived.fulfill()
        }
        
        self.waitForExpectations(timeout: timeout) { error in
            XCTAssertNil(error, "timeout")
        }
    }
    
}
