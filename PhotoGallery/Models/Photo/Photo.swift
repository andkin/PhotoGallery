//
//  Photo.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

struct Photo: Hashable, Decodable {
    let id: String
    let description: String?
    let urls: PhotoURLs
    let user: User
}
