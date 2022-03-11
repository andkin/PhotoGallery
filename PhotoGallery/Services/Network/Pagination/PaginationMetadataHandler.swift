//
//  PaginationMetadataHandler.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

class PaginationMetadataHandler {
    /// Indicates current page index
    private(set) var currentPage: Int = 0
    /// Indicates if we can download next page
    private(set) var hasNextPage: Bool = true
    
    /// Calculates next page index if has next page
    func nextPage() -> Int? {
        guard hasNextPage else { return nil }
        currentPage = currentPage + 1
        Logger.verbose(.pagination, "📃 Next pagination page: \(currentPage)")
        return currentPage
    }
    
    /// Processes error. Consider error as last page of pagination
    func process(error: Error) {
        Logger.verbose(.pagination, "😩 Did receive failure: \(error.localizedDescription)")
        hasNextPage = false
    }
    
    /// Processes empty data. Consider it as last page of pagination
    func processEmptyData() {
        Logger.verbose(.pagination, "📭 Did receive empty data at page: \(currentPage)")
        hasNextPage = false
    }
    
    /// Resets the pagination
    func reset() {
        Logger.verbose(.pagination, "🧐 Did reset pagination metadata")
        currentPage = 0
        hasNextPage = true
    }
}
