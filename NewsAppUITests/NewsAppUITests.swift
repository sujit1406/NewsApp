//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Sujith Antony on 31/03/19.
//  Copyright © 2019 Sujith Antony. All rights reserved.
//

import XCTest

class NewsAppUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testIntroScreenHasProperUIElements() {
        XCTAssert(app.tables["NewsFeedTable"].exists)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewsFeed(){
        let today = Date()
        let todayStr = today.toString(dateFormat: "yyyy-MM-dd")
        
        let tablesQuery = app.tables["NewsFeedTable"]
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", todayStr)
        Thread.sleep(forTimeInterval: 1)
        let count = tablesQuery.cells.count
        XCTAssert(count == 20)
        let firstCell = tablesQuery.children(matching: .cell).element(boundBy: 0).staticTexts.element(matching: predicate)
        //XCTAssert(firstCell.exists)//
        
        let secondCell = tablesQuery.children(matching: .cell).element(boundBy: 1).staticTexts.element(matching: predicate)
       // XCTAssert(secondCell.exists)//
        
        
        let firstCellwithoutpredicate = tablesQuery.children(matching: .cell).firstMatch
        firstCellwithoutpredicate.tap()
        
         // XCTAssert(app.l["NewsFeedTable"].exists)
        
        XCTAssert(app.staticTexts["titleLabel"].exists)
        XCTAssert(app.staticTexts["byLabel"].exists)
        XCTAssert(app.images["DetailsImage"].exists)
        XCTAssert(app.staticTexts["DetailsText"].exists)
        

    }
    
    
        func testNewsFeedLandScape(){
        let today = Date()
        let todayStr = today.toString(dateFormat: "yyyy-MM-dd")
        
        XCUIDevice.shared.orientation = .landscapeLeft
        let tablesQuery = app.tables["NewsFeedTable"]
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", todayStr)
        Thread.sleep(forTimeInterval: 1)
        let count = tablesQuery.cells.count
        XCTAssert(count == 20)
        let firstCell = tablesQuery.children(matching: .cell).element(boundBy: 0).staticTexts.element(matching: predicate)
        XCTAssert(firstCell.exists && firstCell.isHittable)//
        
        let secondCell = tablesQuery.children(matching: .cell).element(boundBy: 1).staticTexts.element(matching: predicate)
        XCTAssert(secondCell.exists && secondCell.isHittable)//
        
        
        XCUIDevice.shared.orientation = .landscapeRight
        XCTAssert(firstCell.exists && firstCell.isHittable)//
        XCTAssert(secondCell.exists && secondCell.isHittable)
    }
    

}
