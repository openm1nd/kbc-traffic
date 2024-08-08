//
//  kbc_trafficUITests.swift
//  kbc-trafficUITests
//
//  Created by Dimitar Marinov on 8.08.24.
//

import XCTest

final class TrafficLight: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrafficLight() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let testModelName = "XC UI TEST"
        
        let modelName = app.tables.textFields["ModelName"]
        modelName.tap()
        modelName.typeText(testModelName)
        
        let startDrivingCell = app.tables.cells["StartDriving"]
                XCTAssertTrue(startDrivingCell.exists, "Identifier StartDriving not found.")
        startDrivingCell.tap()
        
        
        let red = app.otherElements["light-0"]
        let yellow = app.otherElements["light-1"]
        let green = app.otherElements["light-2"]

        XCTAssert(waitForElementToAppear(red, "exists == true", 10), "No traffic light found")
        
        
        
        XCTAssertEqual(app.staticTexts["modelName"].label, testModelName, "Model name appears different")
        
        
        XCTAssert(waitForElementToAppear(red, "value == \"1\"", 2), "Not lighting")
        
        XCTAssert(waitForElementToAppear(yellow, "value == \"1\"", 4), "Not lighting")
        
        XCTAssert(waitForElementToAppear(green, "value == \"1\"", 2), "Not lighting")
        
        XCTAssert(waitForElementToAppear(red, "value == \"0\"", 4), "Not turning off")
        
    }
}
