//
//  LayoutType.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

enum LayoutType: Int, CaseIterable {
    case list
    case grid
    
    var title: String {
        switch self {
        case .list:
            return "List"
        case .grid:
            return "Grid"
        }
    }
}
