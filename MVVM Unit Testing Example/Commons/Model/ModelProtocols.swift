//
//  ModelProtocols.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import Foundation

protocol Model: Codable, Equatable {
    
    associatedtype TableCellViewModelType: TableCellViewModel
    
    init()
    init(from tableCellViewModel: TableCellViewModelType)
    
}
