//
//  kbc_trafficUITests.swift
//  kbc-trafficUITests
//
//  Created by Dimitar Marinov on 8.08.24.
//

import XCTest

final class ModelNameLength: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelNameLength() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let modelName = app.tables.textFields["ModelName"]
        modelName.tap()
        modelName.typeText("")
        
        let startDrivingCell = app.tables.cells["StartDriving"]
                XCTAssertTrue(startDrivingCell.exists, "Identifier StartDriving not found.")
        startDrivingCell.tap()
        
        
        XCTAssert(waitForElementToAppear(app.alerts["Error"], "exists == true", 10), "Error for incorrect model name missing")
        
        let okButton = app.alerts.buttons["OK"]
        XCTAssert(okButton.exists, "OK button does not exist")
        okButton.tap()
        
        modelName.tap()
        modelName.typeText("12 ")
        startDrivingCell.tap()
        
        XCTAssert(waitForElementToAppear(app.alerts["Error"], "exists == true", 10), "Error for incorrect model name missing")
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
