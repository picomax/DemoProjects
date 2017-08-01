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
        
        Music.requestMusic(term: "someone") { (error, musics) in
            //do test
            
            arrived.fulfill()
        }
        
        self.waitForExpectations(timeout: timeout) { error in
            XCTAssertNil(error, "timeout")
        }
    }
    
    func testMovie() {
        stub(condition: { (req) -> Bool in
            return true
        }) { (req) -> OHHTTPStubsResponse in
            let path = Bundle.main.path(forResource: "movie-200", ofType: "json")!
            return fixture(filePath: path, status: 200, headers: [:])
        }
        
        let arrived = self.expectation(description: #function)
        
        Movie.requestMovie(term: "someone") { (error, movies) in
            //do test
            
            arrived.fulfill()
        }
        
        self.waitForExpectations(timeout: timeout) { error in
            XCTAssertNil(error, "timeout")
        }
    }
    
    func testEbook() {
        stub(condition: { (req) -> Bool in
            return true
        }) { (req) -> OHHTTPStubsResponse in
            let path = Bundle.main.path(forResource: "ebook-200", ofType: "json")!
            return fixture(filePath: path, status: 200, headers: [:])
        }
        
        let arrived = self.expectation(description: #function)
        
        Ebook.requestEbook(term: "someone") { (error, ebooks) in
            //do test
            
            arrived.fulfill()
        }
        
        self.waitForExpectations(timeout: timeout) { error in
            XCTAssertNil(error, "timeout")
        }
    }
    
    func testTVShow() {
        stub(condition: { (req) -> Bool in
            return true
        }) { (req) -> OHHTTPStubsResponse in
            let path = Bundle.main.path(forResource: "tvshow-200", ofType: "json")!
            return fixture(filePath: path, status: 200, headers: [:])
        }
        
        let arrived = self.expectation(description: #function)
        
        TVShow.requestTVShow(term: "someone") { (error, tvshows) in
            //do test
            
            arrived.fulfill()
        }
        
        self.waitForExpectations(timeout: timeout) { error in
            XCTAssertNil(error, "timeout")
        }
    }
    
}
