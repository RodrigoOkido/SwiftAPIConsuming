//
//  WebConsumingUITests.swift
//  WebConsumingUITests
//
//  Created by Rodrigo Yukio Okido on 11/05/22.
//

import XCTest

class WebConsumingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNowPlayingElements() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        
        let tablesQuery = app.tables
        let movie_cells = tablesQuery.children(matching: .cell).allElementsBoundByIndex.count

        XCTAssertGreaterThan(movie_cells, 8)
    }
    
    func testPopularMoviesElements() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
            
        let firstPopularMovie = app.tables.children(matching: .cell).element(boundBy: 0).exists
        let secondPopularMovie = app.tables.children(matching: .cell).element(boundBy: 1).exists
        
        XCTAssertNotNil(firstPopularMovie)
        XCTAssertNotNil(secondPopularMovie)
    
    }
    
    
    func testMovieDetails() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let tablesQuery = app.tables
        let movieCell = tablesQuery.children(matching: .cell).element(boundBy: 0).isHittable
        
        XCTAssertNotNil(movieCell)

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
