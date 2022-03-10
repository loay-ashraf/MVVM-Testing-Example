//
//  PublicImagesModel.swift
//  MVVM Unit Testing Example
//
//  Created by Loay Ashraf on 10/03/2022.
//

import Foundation

struct PublicImagesModel: Model {

    typealias TableCellViewModelType = PublicImagesTableCellViewModel
    
    let height: Int
    let id: String
    let url: URL
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        
        case height
        case id
        case url
        case width
        
    }
    
    init() {
        height = 0
        id = ""
        url = URL(string: "www.google.com")!
        width = 0
    }
    
    init(from tableCellViewModel: PublicImagesTableCellViewModel) {
        self = tableCellViewModel.model
    }
    
}
