//
//  PhotoGalleryError.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

protocol PhotoGalleryError: LocalizedError, CustomDebugStringConvertible { }

extension PhotoGalleryError {
    var debugDescription: String {
        return localizedDescription
    }
}

/// For those times you want an error but don't really need any details.
struct SomePhotoGalleryError: PhotoGalleryError {
    var errorDescription: String
    var failureReason: String?
    
    init(errorDescription: String, failureReason: String? = nil) {
        self.errorDescription = errorDescription
        self.failureReason = failureReason
    }
    
    init(error: Error) {
        let userInfo = (error as NSError).userInfo
        self.errorDescription = (userInfo[NSLocalizedDescriptionKey] as? String) ?? error.localizedDescription
        self.failureReason = (userInfo[NSLocalizedFailureReasonErrorKey] as? String)
    }
}
