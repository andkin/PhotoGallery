//
//  MoyaProvider+Combine.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Moya
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension MoyaProvider {

    /// Designated request-making method.
    ///
    /// - Parameters:
    ///   - target: Entity, which provides specifications necessary for a `MoyaProvider`.
    ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
    /// - Returns: `AnyPublisher<Response, MoyaError`
    func requestPublisher(_ target: Target, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Response, MoyaError> {
        return MoyaPublisher { [weak self] subscriber in
                return self?.request(target, callbackQueue: callbackQueue, progress: nil) { result in
                    switch result {
                    case let .success(response):
                        _ = subscriber.receive(response)
                        subscriber.receive(completion: .finished)
                    case let .failure(error):
                        subscriber.receive(completion: .failure(error))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}
