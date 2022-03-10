//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import XCTest
@testable import MVVM_Unit_Testing_Example

class b_ViewModelTests: XCTestCase {

    // vmUT = Model under test
    var vmUT: PublicImagesViewModel!
    var mockLogicController: MockPublicImagesLogicController!

    var resultCellViewModels: [PublicImagesTableCellViewModel] = []
    var mockModels: [PublicImagesModel] { return mockLogicController.mockModels }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        vmUT = PublicImagesViewModel()
        mockLogicController = MockPublicImagesLogicController()
        vmUT.logicController = mockLogicController
        vmUT.bindToModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vmUT = nil
        mockLogicController = nil
        try super.tearDownWithError()
    }
    
    func testViewModelLoad() throws {
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await vmUT.load()
            resultCellViewModels = vmUT.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, NetworkingConstants.minimumPageCapacity)
        for (mockModel,cellViewModel) in zip(mockModels, resultCellViewModels) {
            XCTAssertEqual(mockModel.url, cellViewModel.imageURL)
        }
    }
    
    func testViewModelPaginate() throws {
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await vmUT.load()
            let _ = await vmUT.paginate()
            resultCellViewModels = vmUT.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, 2*NetworkingConstants.minimumPageCapacity)
        for (mockModel,cellViewModel) in zip(mockModels, resultCellViewModels) {
            XCTAssertEqual(mockModel.url, cellViewModel.imageURL)
        }
    }
    
    func testViewModelRefresh() throws {
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await vmUT.load()
            let _ = await vmUT.paginate()
            let _ = await vmUT.refresh()
            resultCellViewModels = vmUT.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, NetworkingConstants.minimumPageCapacity)
        for (mockModel,cellViewModel) in zip(mockModels, resultCellViewModels) {
            XCTAssertEqual(mockModel.url, cellViewModel.imageURL)
        }
    }

}
