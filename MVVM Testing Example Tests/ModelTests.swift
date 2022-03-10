//
//  ModelTests.swift
//  MVVM Unit Testing Example Tests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import XCTest
@testable import MVVM_Testing_Example

class a_ModelTests: XCTestCase {

    // mUT = Model under test
    var mUT: PublicImagesLogicController!
    var mockClient: MockCatClient!
    
    var resultModels: [PublicImagesModel] = []
    var mockModels: [PublicImagesModel] { return mockClient.mockModels }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mUT = PublicImagesLogicController()
        mockClient = MockCatClient()
        mUT.webServiceClient = mockClient
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mUT = nil
        mockClient = nil
    }

    func testModelLoad() throws {
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await mUT.load()
            resultModels = mUT.modelList.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(resultModels.isEmpty)
        XCTAssertEqual(resultModels.count, NetworkingConstants.minimumPageCapacity)
        for (mockModel,model) in zip(mockModels, resultModels) {
            XCTAssertEqual(mockModel, model)
        }
    }
    
    func testModelPaginate() throws {
        let paginatedMockModels: Array<PublicImagesModel> = {
            var array = Array<PublicImagesModel>()
            array.append(contentsOf: mockModels)
            array.append(contentsOf: mockModels)
            return array
        }()
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await mUT.load()
            let _ = await mUT.paginate()
            resultModels = mUT.modelList.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(resultModels.isEmpty)
        XCTAssertEqual(resultModels.count, 2*NetworkingConstants.minimumPageCapacity)
        for (mockModel,model) in zip(paginatedMockModels, resultModels) {
            XCTAssertEqual(mockModel, model)
        }
    }
    
    func testModelRefresh() throws {
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await mUT.load()
            let _ = await mUT.paginate()
            let _ = await mUT.refresh()
            resultModels = mUT.modelList.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(resultModels.isEmpty)
        XCTAssertEqual(resultModels.count, NetworkingConstants.minimumPageCapacity)
        for (mockModel,model) in zip(mockModels, resultModels) {
            XCTAssertEqual(mockModel, model)
        }
    }

}
