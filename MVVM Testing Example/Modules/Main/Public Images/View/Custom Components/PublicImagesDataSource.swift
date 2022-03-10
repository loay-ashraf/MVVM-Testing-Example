//
//  PublicImagesDataSource.swift
//  MVVM Unit Testing Example
//
//  Created by Loay Ashraf on 10/03/2022.
//

import UIKit

class PublicImagesDataSource: SKTableViewDataSource<PublicImagesTableCellViewModel> {
    
    override init() {
        super.init()
        cellClass = PublicImagesCell.self
        cellConfigurator = PublicImagesCellConfigurator()
    }
    
}
