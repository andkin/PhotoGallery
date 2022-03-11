//
//  AnyPublisher+Ext.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Moya
import Combine

extension AnyPublisher where Output == Response {
    func mapDecodable<DecodedResponse: Decodable>(type: DecodedResponse.Type) -> AnyPublisher<DecodedResponse, Error> {
        return self.tryMap({
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(DecodedResponse.self, from: $0.data)
        })
        .handleEvents(
            receiveCompletion: { completion in
                guard case .failure(let error) = completion else { return }
                Logger.error(.decoding, "Did decode type \(DecodedResponse.self) with error: \(error)")
            })
        .eraseToAnyPublisher()
    }
}
