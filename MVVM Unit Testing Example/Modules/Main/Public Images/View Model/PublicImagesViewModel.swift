//
//  PublicImagesViewModel.swift
//  MVVM Unit Testing Example
//
//  Created by Loay Ashraf on 10/03/2022.
//

import Foundation

final class PublicImagesViewModel: WebServicePlainTableViewModel {
    
    // MARK: - Properties
    
    typealias TableCellViewModelType = PublicImagesTableCellViewModel
    
    var logicController = PublicImagesLogicController()
    var cellViewModels = Observable<List<PublicImagesTableCellViewModel>>()
    
    // MARK: - Initialization
    
    init() {
        bindToModel()
    }
    
    // MARK: - Bind to Model Method
    
    func bindToModel() {
        logicController.bind { [weak self] modelList in
            if let modelList = modelList {
                let modelItems = modelList.items
                self?.cellViewModelList.items = modelItems.map { return PublicImagesTableCellViewModel(from: $0) }
                self?.cellViewModelList.currentPage = modelList.currentPage
                self?.cellViewModelList.isPaginable = modelList.isPaginable
            }
        }
    }
    
}

final class PublicImagesTableCellViewModel: CellViewModel {
    
    // MARK: - Properties
    
    typealias ModelType = PublicImagesModel
    
    var model: ModelType
    var imageURL: URL
    
    // MARK: - Initialization
    
    init(from model: PublicImagesModel)  {
        self.model = model
        imageURL = model.url
    }
    
}
