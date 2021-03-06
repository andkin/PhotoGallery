//
//  PhotosProps.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

struct PhotosProps: Equatable {
    var isLoadingNextPage: Bool = false
    var layoutType: LayoutType = .list
    var photos: [Photo] = []
}
