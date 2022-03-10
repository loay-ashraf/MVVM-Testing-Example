//
//  ModelProtocols.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import Foundation

protocol Model: Codable, Equatable {
    
    associatedtype TableCellViewModelType: CellViewModel
    
    init()
    init(from tableCellViewModel: TableCellViewModelType)
    
}
