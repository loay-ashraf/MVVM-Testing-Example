//
//  MockLogicController.swift
//  MVVM Unit Testing Example Tests
//
//  Created by Loay Ashraf on 10/03/2022.
//

import Foundation
@testable import MVVM_Unit_Testing_Example

class MockPublicImagesLogicController: PublicImagesLogicController {
    
    let mockModels: Array<PublicImagesModel> = {
        var array = Array<PublicImagesModel>()
        for _ in 1...NetworkingConstants.minimumPageCapacity {
            array.append(PublicImagesModel())
        }
        return array
    }()
    
    override func fetchData() async -> Result<Array<PublicImagesModel>, NetworkError> {
        return .success(mockModels)
    }
    
}
