//
//  Publisher+Ext.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation
import Combine

extension Publisher {
    func sinkResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                result(.failure(error))
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}
