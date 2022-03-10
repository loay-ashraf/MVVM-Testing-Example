//
//  CatClient.swift
//  GitIt
//
//  Created by Loay Ashraf on 18/10/2021.
//

import Foundation

class CatClient: WebServiceClient {
    
    // MARK: - User Search Methods
    
    func fetchPublicImages(page: Int) async -> Result<[PublicImagesModel],NetworkError> {
        return await networkManager.dataRequest(request: CatRouter.fetchPuplicPictures(page: page))
    }

}
