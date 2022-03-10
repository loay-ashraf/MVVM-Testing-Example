//
//  AppTests.swift
//  App Tests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import XCTest

class b_AppTests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testPublicImagesView() throws {
        // UI tests must launch the application that they test.
        var numberofSwipes = 0
        let publicImagesTable = app.tables["public_images_tableview"]
        let publicImagesTableCells = publicImagesTable.cells
        // Test for table existense and cell count
        XCTAssertTrue(publicImagesTable.exists)
        XCTAssertGreaterThan(publicImagesTableCells.count, 0)
        // Test for table pagination
        while publicImagesTableCells.count < 20 {
            guard numberofSwipes < 10 else {
                XCTFail("Table doesn't paginate items")
                return
            }
            publicImagesTable.swipeUp()
            numberofSwipes += 1
        }
        XCTAssertEqual(publicImagesTableCells.count, 20)
    }

}
