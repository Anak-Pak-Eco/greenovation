//
//  Base_ProjectUITestsLaunchTests.swift
//  Base ProjectUITests
//
//  Created by Naufal Fawwaz Andriawan on 29/09/23.
//

import XCTest

final class GreenovationUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
