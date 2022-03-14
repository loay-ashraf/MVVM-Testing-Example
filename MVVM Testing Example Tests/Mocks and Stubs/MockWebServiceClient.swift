//
//  MockWebServiceClient.swift
//  MVVM Unit Testing Example Tests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import Foundation
@testable import MVVM_Testing_Example

class MockCatClient: CatClient {
    
    let stubbedResponse: Array<PublicImagesModel> = {
        var array = Array<PublicImagesModel>()
        for _ in 1...NetworkingConstants.minimumPageCapacity {
            array.append(PublicImagesModel())
        }
        return array
    }()
    
    var isFetchPublicImagesCalled = false
    
    override func fetchPublicImages(page: Int) async -> Result<[PublicImagesModel], NetworkError> {
        isFetchPublicImagesCalled = true
        return .success(stubbedResponse)
    }
    
}
