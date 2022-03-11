//
//  PaginationResponseModel.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

//MARK: - Pagination model
struct PaginationResponseModel: Decodable, Hashable {
    var pagesAmount: Int
    
    static func empty() -> PaginationResponseModel {
        return PaginationResponseModel(pagesAmount: 0)
    }
}
