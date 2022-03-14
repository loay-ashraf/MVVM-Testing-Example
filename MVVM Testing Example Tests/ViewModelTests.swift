//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import XCTest
@testable import MVVM_Testing_Example

class b_ViewModelTests: XCTestCase {

    // vmUT = Model under test
    var vmUT: PublicImagesViewModel!
    var mockLogicController: MockPublicImagesLogicController!

    var resultCellViewModels: [PublicImagesTableCellViewModel] = []
    var stubbedModel: [PublicImagesModel] { return mockLogicController.stubbedModel }
    
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
        XCTAssertTrue(mockLogicController.isFetchDataCalled)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, NetworkingConstants.minimumPageCapacity)
        for (stubbedModelItem,resultCellViewModelItem) in zip(stubbedModel, resultCellViewModels) {
            XCTAssertEqual(stubbedModelItem.url, resultCellViewModelItem.imageURL)
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
        XCTAssertTrue(mockLogicController.isFetchDataCalled)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, 2*NetworkingConstants.minimumPageCapacity)
        for (stubbedModelItem,resultCellViewModelItem) in zip(stubbedModel, resultCellViewModels) {
            XCTAssertEqual(stubbedModelItem.url, resultCellViewModelItem.imageURL)
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
        XCTAssertTrue(mockLogicController.isFetchDataCalled)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, NetworkingConstants.minimumPageCapacity)
        for (stubbedModelItem,resultCellViewModelItem) in zip(stubbedModel, resultCellViewModels) {
            XCTAssertEqual(stubbedModelItem.url, resultCellViewModelItem.imageURL)
        }
    }

}
