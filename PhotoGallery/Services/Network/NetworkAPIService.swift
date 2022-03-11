//
//  NetworkAPIService.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation
import Moya
import Combine

/// A service that provides bridge to the Moya provider class .
///
/// Use ``NetworkAPIService`` as base abstraction class for your custom API classes.
class NetworkAPIService<Target> where Target: Moya.TargetType {
    
    var provider: MoyaProvider<Target>
    
    private lazy var concurrentDispatchQueueScheduler: DispatchQueue = {
        return DispatchQueue(label: "\(self).queue",
                             qos: .utility,
                             attributes: [.concurrent],
                             target: nil)
    }()
    
    init(stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub) {
        
        let session = Session(configuration: URLSessionConfiguration.default)
        
        let logging = NetworkAPILogger(verbose: true,
                                       cURL: false,
                                       requestDataFormatter: NetworkAPILogger.JSONRequestDataFormatter,
                                       responseDataFormatter: NetworkAPILogger.JSONResponseDataFormatter)
        
        provider = MoyaProvider(stubClosure: stubClosure,
                                session: session,
                                plugins: [logging])
    }
    
    func request(_ target: Target) -> AnyPublisher<Response, PhotoGalleryApiError> {
        let actualRequest = provider.requestPublisher(target)
            .filterResponse()
            .subscribe(on: concurrentDispatchQueueScheduler)
            .receive(on: concurrentDispatchQueueScheduler)
            .eraseToAnyPublisher()
        return actualRequest
    }
}

extension AnyPublisher where Output == Response, Failure == MoyaError {
    func filterResponse() -> AnyPublisher<Response, PhotoGalleryApiError> {
        return self.mapError({ error in
            return PhotoGalleryApiError.moyaError(error)
        })
        .flatMap({ response -> AnyPublisher<Response, PhotoGalleryApiError> in
            return Future { promise in
                do {
                    promise(.success(try response.filterStatusCodes()))
                } catch {
                    guard let error = error as? PhotoGalleryApiError else {
                        promise(.failure(PhotoGalleryApiError.unknown)); return
                    }
                    promise(.failure(error))
                }
            }.eraseToAnyPublisher()
        })
        .eraseToAnyPublisher()
    }
}

private extension Response {
    func filterStatusCodes() throws -> Response {
        switch self.statusCode {
        case 200...399:
            return self
        case 403:
            throw PhotoGalleryApiError.unauthorised
        case 400...499:
            if let error = try? JSONDecoder().decode(PhotoGalleryApiErrorResponse.self, from: self.data) {
                throw PhotoGalleryApiError.networkError(error: error)
            } else {
                throw PhotoGalleryApiError.internalServerError
            }
        case 500...511:
            throw PhotoGalleryApiError.internalServerError
        default:
            throw PhotoGalleryApiError.unknown
        }
    }
}
