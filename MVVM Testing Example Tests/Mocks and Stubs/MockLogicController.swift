//
//  MockLogicController.swift
//  MVVM Unit Testing Example Tests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import Foundation
@testable import MVVM_Testing_Example

class MockPublicImagesLogicController: PublicImagesLogicController {
    
    let stubbedModel: Array<PublicImagesModel> = {
        var array = Array<PublicImagesModel>()
        for _ in 1...NetworkingConstants.minimumPageCapacity {
            array.append(PublicImagesModel())
        }
        return array
    }()
    
    var isFetchDataCalled = false
    
    override func fetchData() async -> Result<Array<PublicImagesModel>, NetworkError> {
        isFetchDataCalled = true
        return .success(stubbedModel)
    }
    
}
