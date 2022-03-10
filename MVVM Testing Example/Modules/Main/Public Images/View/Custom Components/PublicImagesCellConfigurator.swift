//
//  PublicImagesCellConfigurator.swift
//  MVVM Unit Testing Example
//
//  Created by Loay Ashraf on 10/03/2022.
//

import UIKit

class PublicImagesCellConfigurator: TableViewCellConfigurator {
    
    override func configure<Type>(_ cell: UITableViewCell, forDisplaying item: Type) {
        if let cell = cell as? PublicImagesCell, let item = item as? PublicImagesTableCellViewModel {
            cell.publicImageView.load(at: item.imageURL)
            cell.setNeedsLayout()
        }
    }
    
}
