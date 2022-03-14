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
    
    var resultResponse: [PublicImagesModel] = []
    var stubbedResponse: [PublicImagesModel] { return mockClient.stubbedResponse }
    
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
            resultResponse = mUT.modelList.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(mockClient.isFetchPublicImagesCalled)
        XCTAssertFalse(resultResponse.isEmpty)
        XCTAssertEqual(resultResponse.count, NetworkingConstants.minimumPageCapacity)
        for (stubbedResponseItem,responseItem) in zip(stubbedResponse, resultResponse) {
            XCTAssertEqual(stubbedResponseItem, responseItem)
        }
    }
    
    func testModelPaginate() throws {
        let paginatedStubbedResponse: Array<PublicImagesModel> = {
            var array = Array<PublicImagesModel>()
            array.append(contentsOf: stubbedResponse)
            array.append(contentsOf: stubbedResponse)
            return array
        }()
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await mUT.load()
            let _ = await mUT.paginate()
            resultResponse = mUT.modelList.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(mockClient.isFetchPublicImagesCalled)
        XCTAssertFalse(resultResponse.isEmpty)
        XCTAssertEqual(resultResponse.count, 2*NetworkingConstants.minimumPageCapacity)
        for (stubbedResponseItem,responseItem) in zip(paginatedStubbedResponse, resultResponse) {
            XCTAssertEqual(stubbedResponseItem, responseItem)
        }
    }
    
    func testModelRefresh() throws {
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await mUT.load()
            let _ = await mUT.paginate()
            let _ = await mUT.refresh()
            resultResponse = mUT.modelList.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(mockClient.isFetchPublicImagesCalled)
        XCTAssertFalse(resultResponse.isEmpty)
        XCTAssertEqual(resultResponse.count, NetworkingConstants.minimumPageCapacity)
        for (stubbedResponseItem,responseItem) in zip(stubbedResponse, resultResponse) {
            XCTAssertEqual(stubbedResponseItem, responseItem)
        }
    }

}
