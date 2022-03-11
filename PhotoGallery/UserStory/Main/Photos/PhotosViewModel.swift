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
    private let pageManager = PaginationMetadataHandler()
    private var cancellableBag: Set<AnyCancellable> = []
    private var props = PhotosProps()
    
    func changeLayout(_ layoutType: LayoutType) {
        props.layoutType = layoutType
        delegate?.didUpdate(props: props)
    }
    
    func loadNextPage() {
        guard props.isLoadingNextPage == false,
              let nextPage = pageManager.nextPage() else { return }
        
        props.isLoadingNextPage = true
        delegate?.didUpdate(props: props)
        
        fetchPhotos(page: nextPage)
    }
    
    private func fetchPhotos(page: Int) {
        unsplashService
            .request(.getPhotoList(page: page))
            .mapDecodable(type: [Photo].self)
            .receive(on: DispatchQueue.main)
            .sinkResult { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.stopLoading(with: .success(response))
                case .failure(let error):
                    Logger.error(.photos, "Did fail to load photos list with error: \(error)")
                    self.stopLoading(with: .failure(error))
                    self.delegate?.didFailToLoadPhotosWithError(error)
                }
                
                self.delegate?.didUpdate(props: self.props)
            }
            .store(in: &cancellableBag)
    }
    
    private func stopLoading(with result: Swift.Result<[Photo], Error>) {
        switch result {
        case .success(let response):
            response.isEmpty
            ? pageManager.processEmptyData()
            : props.photos.append(contentsOf: response)
        case .failure(let error):
            pageManager.process(error: error)
        }
        
        props.isLoadingNextPage = false
        delegate?.didUpdate(props: props)
    }
}
