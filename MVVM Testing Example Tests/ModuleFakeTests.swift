//
//  y_ModuleFakeTests.swift
//  MVVM Testing Example Tests
//
//  Created by Loay Ashraf on 14/03/2022.
//

import XCTest
import OHHTTPStubs
@testable import MVVM_Testing_Example

class y_ModuleFakeTests: XCTestCase {

    // vmUT = Model under test
    var vmUT: PublicImagesViewModel!

    var resultCellViewModels: [PublicImagesTableCellViewModel] = []
    var stubbedResponse: Array<Dictionary<String, AnyObject>> = {
        let bundle = Bundle(for: y_ModuleFakeTests.self)
        if let path = bundle.path(forResource: "StubbedResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonResult = jsonResult as? Array<Dictionary<String, AnyObject>> {
                    return jsonResult
                }
            } catch {
                return Array<Dictionary<String, AnyObject>>()
            }
        }
        return Array<Dictionary<String, AnyObject>>()
    }()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        vmUT = PublicImagesViewModel()
        stub(condition: isHost("api.thecatapi.com")) { _ in
            let stubPath = OHPathForFile("StubbedResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        HTTPStubs.removeAllStubs()
        vmUT = nil
        try super.tearDownWithError()
    }

    func testModuleLoad() throws {
        let expectation = expectation(description: "Fetch Timed out")
        Task {
            let _ = await vmUT.load()
            resultCellViewModels = vmUT.items
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(resultCellViewModels.isEmpty)
        XCTAssertEqual(resultCellViewModels.count, NetworkingConstants.minimumPageCapacity)
        for (stubbedResponseItem,resultCellViewModelItem) in zip(stubbedResponse, resultCellViewModels) {
            let stubbedResponseItemURL = URL(string: stubbedResponseItem["url"] as! String)
            XCTAssertEqual(stubbedResponseItemURL, resultCellViewModelItem.imageURL)
        }
    }
    
    func testModulePaginate() throws {
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
        for (stubbedResponseItem,resultCellViewModelItem) in zip(stubbedResponse, resultCellViewModels) {
            let stubbedResponseItemURL = URL(string: stubbedResponseItem["url"] as! String)
            XCTAssertEqual(stubbedResponseItemURL, resultCellViewModelItem.imageURL)
        }
    }
    
    func testModuleRefresh() throws {
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
        for (stubbedResponseItem,resultCellViewModelItem) in zip(stubbedResponse, resultCellViewModels) {
            let stubbedResponseItemURL = URL(string: stubbedResponseItem["url"] as! String)
            XCTAssertEqual(stubbedResponseItemURL, resultCellViewModelItem.imageURL)
        }
    }

}
