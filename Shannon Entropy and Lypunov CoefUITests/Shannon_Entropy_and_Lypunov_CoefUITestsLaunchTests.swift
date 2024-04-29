//
//  Shannon_Entropy_and_Lypunov_CoefUITestsLaunchTests.swift
//  Shannon Entropy and Lypunov CoefUITests
//
//  Created by Marco Gonzalez on 4/29/24.
//

import XCTest

final class Shannon_Entropy_and_Lypunov_CoefUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
