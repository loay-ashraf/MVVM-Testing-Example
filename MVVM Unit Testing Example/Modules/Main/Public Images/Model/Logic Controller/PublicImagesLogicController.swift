//
//  PublicImagesLogicController.swift
//  MVVM Unit Testing Example
//
//  Created by Loay Ashraf on 10/03/2022.
//

import Foundation

class PublicImagesLogicController: WebServicePlainLogicController {
    
    // MARK: - Properties
    
    typealias WebServiceClientType = CatClient
    typealias ModelType = PublicImagesModel
    
    var webServiceClient = CatClient()
    var model = Observable<List<PublicImagesModel>>()
    var maxItemCount: Int?
    var maxPageCount: Int
    
    // MARK: - Initialization
    
    required init(maxItemCount: Int?, maxPageCount: Int = NetworkingConstants.maxPageCount) {
        self.maxItemCount = maxItemCount
        self.maxPageCount = maxPageCount
        modelList.isPaginable = true
    }
    
    // MARK: - Fetch Data Method
    
    func fetchData() async -> Result<Array<PublicImagesModel>,NetworkError> {
        await webServiceClient.fetchPublicImages(page: modelList.currentPage)
    }
    
    
}
