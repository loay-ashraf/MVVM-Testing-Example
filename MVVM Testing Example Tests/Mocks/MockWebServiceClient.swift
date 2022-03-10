//
//  MockWebServiceClient.swift
//  MVVM Unit Testing Example Tests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import Foundation
@testable import MVVM_Unit_Testing_Example

class MockCatClient: CatClient {
    
    let mockModels: Array<PublicImagesModel> = {
        var array = Array<PublicImagesModel>()
        for _ in 1...NetworkingConstants.minimumPageCapacity {
            array.append(PublicImagesModel())
        }
        return array
    }()
    
    override func fetchPublicImages(page: Int) async -> Result<[PublicImagesModel], NetworkError> {
        return .success(mockModels)
    }
    
}
