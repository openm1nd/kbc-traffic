//
//  kbc_trafficUITestsLaunchTests.swift
//  kbc-trafficUITests
//
//  Created by Dimitar Marinov on 8.08.24.
//

import XCTest

extension XCTestCase {
    func waitForElementToAppear(_ element: Any, _ condition: String, _ time: Int) -> Bool {
        let predicate = NSPredicate(format: condition)
        let e = expectation(for: predicate, evaluatedWith: element,
                            handler: nil)
        
        let result = XCTWaiter().wait(for: [e], timeout: TimeInterval(time))
        return result == .completed
    }
}
