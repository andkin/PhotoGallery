//
//  LogCategory.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

enum LogCategory: String {
    
    //System
    case plugin = "Plugin"
    case router = "Router"
    
    //Networking
    case networking = "Networking"
    case decoding = "Network Decoding"
    case pagination = "Pagination"
    
    //Custom
    case photos = "Photos"
    
    case unknown = "Unknown"
}

