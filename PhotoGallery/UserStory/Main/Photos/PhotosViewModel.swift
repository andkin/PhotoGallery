//
//  PhotosViewModel.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation
import Combine

protocol PhotosViewModelDelegate: AnyObject {
    func didUpdate(props: PhotosProps)
    func didFailToLoadPhotosWithError(_ error: Error)
}

class PhotosViewModel {
    
    weak var delegate: PhotosViewModelDelegate?
    
    private let unsplashService = OnlineProvider<UnsplashAPI>()
    private var cancellableBag: Set<AnyCancellable> = []
    private var props = PhotosProps()
    
    func viewDidLoad() {
        fetchPhotos()
    }
    
    func changeLayout(_ layoutType: LayoutType) {
        props.layoutType = layoutType
        delegate?.didUpdate(props: props)
    }
    
    private func fetchPhotos() {
        self.unsplashService
            .request(.getPhotoList)
            .mapDecodable(type: [Photo].self)
            .receive(on: DispatchQueue.main)
            .sinkResult { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.props.photos = response
                    Logger.verbose(.photos, "🗂 Number of loaded repositories is \(response.count)")
                case .failure(let error):
                    Logger.error(.photos, "Did fail to load repositories list with error: \(error)")
                    self.delegate?.didFailToLoadPhotosWithError(error)
                }
                
                self.delegate?.didUpdate(props: self.props)
            }
            .store(in: &cancellableBag)
    }
}
