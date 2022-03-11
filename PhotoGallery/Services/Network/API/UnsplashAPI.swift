//
//  UnsplashAPI.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation
import Moya

enum UnsplashAPI {
    case getPhotoList
}

extension UnsplashAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }
    
    var path: String {
        switch self {
        case .getPhotoList:
            return "photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotoList:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default: return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .getPhotoList:
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default: return nil
        }
    }
    
    private var requestParameters: [String: Any] {
        switch self {
        case .getPhotoList:
            return [:]
        }
    }
}

extension UnsplashAPI: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        default:
            return .custom("Client-ID")
        }
    }
}
