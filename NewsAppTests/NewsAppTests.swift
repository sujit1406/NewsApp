//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Sujith Antony on 31/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchNewsFeedForDay() {
        let presenter  = NewsFeedPresenter()
          let expect = expectation(description: "Response received")
        presenter.fetchNewsFeed(for: NewsFetchPeriod.day) {
            if let extracted = presenter.filteredTableData?.count{
                  expect.fulfill()
                let expected = 20
                XCTAssertEqual(extracted, expected, "Failed to extract full entities")
            }
        }
         waitForExpectations(timeout: 4, handler: nil)
    }
    
    func testFetchNewsFeedForWeek() {
        let presenter  = NewsFeedPresenter()
          let expect = expectation(description: "Response received")
        presenter.fetchNewsFeed(for: NewsFetchPeriod.week) {
            if let extracted = presenter.filteredTableData?.count{
                  expect.fulfill()
                let expected = 20
                XCTAssertEqual(extracted, expected, "Failed to extract full entities")
            }
        }
         waitForExpectations(timeout: 4, handler: nil)
    }
    
    
    func testFetchNewsFeedForMonth() {
        let presenter  = NewsFeedPresenter()
          let expect = expectation(description: "Response received")
        presenter.fetchNewsFeed(for: NewsFetchPeriod.month) {
            if let extracted = presenter.filteredTableData?.count{
                  expect.fulfill()
                let expected = 20
                XCTAssertEqual(extracted, expected, "Failed to extract full entities")
            }
        }
         waitForExpectations(timeout: 4, handler: nil)
    }
    
    func testLoadImages() {
        let presenter  = NewsFeedPresenter()
        let expect = expectation(description: "Response received")
        var count = 0
        presenter.fetchNewsFeed(for: NewsFetchPeriod.day) {
            if let extracted = presenter.filteredTableData{
                for item in extracted{
                    if let imageurl = item.media?.first?.mediaData?.first?.url{
                            APIClient.getImage(url: imageurl) { (image) in
                                if(image.pngData()?.count == 0){
                                    XCTAssert(true, "image is nil")
                                }else{
                                    count = count + 1
                                    if(count == 20){
                                        expect.fulfill()
                                    }
                                }
                            }
                        }
                    }
                }
            }
         waitForExpectations(timeout: 4, handler: nil)
    }



}
