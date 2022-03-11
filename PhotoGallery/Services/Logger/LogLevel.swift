//
//  LogLevel.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

enum LogLevel: Int {
    
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4

    var iconSymbol: String {
        switch self {
        case .verbose:
            return "⚪"
        case .debug:
            return "🟢"
        case .info:
            return "🔵"
        case .warning:
            return "🟠"
        case .error:
            return "🔴"
        }
    }
}
