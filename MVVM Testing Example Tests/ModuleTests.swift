//
//  ModuleTests.swift
//  MVVM Unit Testing Example Tests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import XCTest
import Alamofire
@testable import MVVM_Unit_Testing_Example

class z_ModuleTests: XCTestCase {

    // vmUT = Model under test
    var vmUT: PublicImagesViewModel!

    var resultLoadNetworkError: NetworkError?
    var resultPaginateNetworkError: NetworkError?
    var resultRefreshNetworkError: NetworkError?
    var resultCellViewModels: [PublicImagesTableCellViewModel] = []
    
    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        vmUT = PublicImagesViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vmUT = nil
        try super.tearDownWithError()
    }

    func testModuleLoad() throws {
        try XCTSkipUnless(reachabilityManager.isReachable,"Network connectivity needed for this test.")
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            resultLoadNetworkError = await vmUT.load()
            resultCellViewModels = vmUT.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(resultLoadNetworkError)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, NetworkingConstants.minimumPageCapacity)
    }
    
    func testModulePaginate() throws {
        try XCTSkipUnless(reachabilityManager.isReachable,"Network connectivity needed for this test.")
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            resultLoadNetworkError = await vmUT.load()
            resultPaginateNetworkError = await vmUT.paginate()
            resultCellViewModels = vmUT.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(resultLoadNetworkError)
        XCTAssertNil(resultPaginateNetworkError)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, 2*NetworkingConstants.minimumPageCapacity)
    }
    
    func testModuleRefresh() throws {
        try XCTSkipUnless(reachabilityManager.isReachable,"Network connectivity needed for this test.")
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            resultLoadNetworkError = await vmUT.load()
            resultPaginateNetworkError = await vmUT.paginate()
            resultRefreshNetworkError = await vmUT.refresh()
            resultCellViewModels = vmUT.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(resultLoadNetworkError)
        XCTAssertNil(resultPaginateNetworkError)
        XCTAssertNil(resultRefreshNetworkError)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, NetworkingConstants.minimumPageCapacity)
    }

}
