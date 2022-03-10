//
//  PublicImagesViewController.swift
//  MVVM Unit Testing Example
//
//  Created by Loay Ashraf on 10/03/2022.
//

import UIKit

class PublicImagesViewController: WSSFDynamicTableViewController<PublicImagesViewModel>{
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableViewDataSource = PublicImagesDataSource()
        tableViewDelegate = TableViewDelegate()
        viewModel = PublicImagesViewModel()
        emptyViewModel = EmptyConstants.General.viewModel
        bindToViewModel()
    }
    
    deinit {
        debugPrint(String(describing: self) + " deallocated")
    }

    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load(with: .initial)
    }
    
    // MARK: - View Helper Methods
    
    override func configureView() {
        super.configureView()

        xTableView.accessibilityIdentifier = "public_images_tableview"
        xTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Loading Methods
    
    override func load(with loadingViewState: LoadingViewState) {
        super.load(with: loadingViewState)
        if loadingViewState == .initial, didLoadInitial { return }
        else { didLoadInitial = true }
        Task {
            switch loadingViewState {
            case .initial: loadHandler(error: await viewModel?.load())
            case .refresh: refreshHandler(error: await viewModel?.refresh())
            case .paginate: paginateHandler(error: await viewModel?.paginate())
            }
        }
    }
    
    // MARK: - Bind to View Model Method
    
    func bindToViewModel() {
        viewModel.bind { [weak self] cellViewModelList in
            if let cellViewModelList = cellViewModelList {
                self?.tableViewDataSource.cellViewModels = cellViewModelList.items
            }
        }
    }
    
}
