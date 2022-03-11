//
//  PhotoURLs.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

struct PhotoURLs: Hashable, Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
