//
//  PhotosDataSource.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

class PhotosDataSource: UICollectionViewDiffableDataSource<PhotosView.Section, PhotosView.Item> {
    
    typealias Section = PhotosView.Section
    typealias Item = PhotosView.Item
    typealias Props = PhotosProps
    
    private var props = Props()
    
    func apply(props: Props, animated: Bool = true) {
        self.props = props
        reloadData(animatingDifferences: animated)
    }
    
    func reload(animated: Bool = true) {
        reloadData(animatingDifferences: animated)
    }
    
    // MARK: - Data Reload
    private func reloadData(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.main(layoutType: props.layoutType)])
        
        props.photos.forEach {
            snapshot.appendItems([.photo(item: $0, layoutType: props.layoutType)],
                                 toSection: .main(layoutType: props.layoutType))
        }
        
        snapshot.appendItems([.spinner(isActive: props.isLoadingNextPage)],
                             toSection: .main(layoutType: props.layoutType))
        
        DispatchQueue.main.async {
            self.apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }
}
