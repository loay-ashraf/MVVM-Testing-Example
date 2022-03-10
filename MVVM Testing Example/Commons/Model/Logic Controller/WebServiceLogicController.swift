//
//  WebServiceLogicController.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import Foundation

// MARK: - Protocol Definition

protocol WebServiceLogicController: AnyObject {
    
    associatedtype WebServiceClientType: WebServiceClient
    associatedtype ModelType: Model
    
    var webServiceClient: WebServiceClientType { get }
    var model: Observable<List<ModelType>> { get set }
    var modelList: List<ModelType> { get set }
    var maxItemCount: Int? { get }
    var maxPageCount: Int { get }
    
    init()
    init(maxItemCount: Int?, maxPageCount: Int)
    
    func fetchData() async -> Result<Array<ModelType>,NetworkError>
    func resetData()
    func processFetchResult(result: Result<Array<ModelType>, NetworkError>) -> NetworkError?
    func updatePaginability(newItemsCount: Int)
    func bind(_ listener: @escaping (List<ModelType>?) -> Void)
    
}

protocol WebServicePlainLogicController: WebServiceLogicController {

    func load() async -> NetworkError?
    func refresh() async -> NetworkError?
    func paginate() async -> NetworkError?

}

// MARK: - Protocol Extensions

extension WebServiceLogicController {
    
    // MARK: - Properties
    
    var modelList: List<ModelType> {
        get { return model.value ?? List<ModelType>() }
        set { model.value = newValue }
    }
    
    // MARK: - Initialization
    
    init() {
        self.init(maxItemCount: nil, maxPageCount: 0)
    }
    
    // MARK: - Reset Method
    
    func resetData() {
        modelList.reset(isPagiable: true)
    }
    
    // MARK: - Fetch Result Processing Methods
    
    func processFetchResult(result: Result<Array<ModelType>, NetworkError>) -> NetworkError? {
        switch result {
        case .success(let response): modelList.append(contentsOf: response, withSizeLimit: maxItemCount)
                                     updatePaginability(newItemsCount: response.count)
                                     return nil
        case .failure(let networkError): return networkError
        }
    }
    
    // MARK: - Model Paginability Update Method
    
    func updatePaginability(newItemsCount: Int) {
        if modelList.count == maxItemCount || modelList.currentPage == maxPageCount || newItemsCount < NetworkingConstants.minimumPageCapacity {
            modelList.isPaginable = false
        } else {
            modelList.currentPage += 1
        }
    }
    
    // MARK: - Bind Method
    
    func bind(_ listener: @escaping (List<ModelType>?) -> Void) {
        model.bind(listener)
    }
    
}

extension WebServicePlainLogicController {
    
    // MARK: - Load, Refresh and Paginate methods

    func load() async -> NetworkError? {
        return processFetchResult(result: await fetchData())
    }
    
    func refresh() async -> NetworkError? {
        resetData()
        return processFetchResult(result: await fetchData())
    }
    
    func paginate() async -> NetworkError? {
        return processFetchResult(result: await fetchData())
    }
    
}
