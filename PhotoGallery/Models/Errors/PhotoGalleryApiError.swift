//
//  PhotoGalleryApiError.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

enum PhotoGalleryApiError: PhotoGalleryError {
    case unknown
    case internalServerError
    case unauthorised
    case moyaError(Error)
    case networkError(error: PhotoGalleryApiErrorResponse)
    
    var errorDescription: String? {
        switch self {
        case .unknown, .moyaError: return "Unknown Error"
        case .unauthorised: return "Unauthorised"
        case .internalServerError: return "Internal Server Error"
        case .networkError(let error): return error.reason.localizedMessage
        }
    }
}

struct PhotoGalleryApiErrorResponse: Codable {
    let code: Int
    let reason: PhotoGalleryApiErrorReason
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case reason = "message"
        case description = "description"
    }
}

enum PhotoGalleryApiErrorReason: String, Codable {
    case unknown
    
    var localizedMessage: String {
        switch self {
        case .unknown: return "Unknown Error"
        }
    }
}
