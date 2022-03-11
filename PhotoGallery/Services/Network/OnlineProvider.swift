//
//  OnlineProvider.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation
import Moya
import Combine

class OnlineProvider<Target> where Target: Moya.TargetType {
    
    var provider: MoyaProvider<Target>

    private let concurrentDispatchQueueScheduler = DispatchQueue(label: "onlineprovider.queue",
                                                                 qos: .utility,
                                                                 attributes: [],
                                                                 target: nil)
    
    init(stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub) {
        
        let session = Session(configuration: URLSessionConfiguration.default)
        
        let accessToken = AccessTokenPlugin { _ in
            return "aTu-N-MIHkk2ojXjGomFBfghZdE9znDQnIa3y7KbCs0"
        }
        
        let logging = NetworkAPILogger(verbose: true,
                                       cURL: false,
                                       requestDataFormatter: NetworkAPILogger.JSONRequestDataFormatter,
                                       responseDataFormatter: NetworkAPILogger.JSONResponseDataFormatter)
        
        provider = MoyaProvider(stubClosure: stubClosure,
                                session: session,
                                plugins: [logging, accessToken])
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
