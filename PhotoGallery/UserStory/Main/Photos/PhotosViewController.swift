//
//  PhotosViewController.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let viewModel: PhotosViewModel
    private let router: PhotosVCRoutingProtocol
    private let contentView: PhotosView
    
    init(viewModel: PhotosViewModel,
        router: PhotosVCRoutingProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.contentView = PhotosView()
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

// MARK: - ViewModel Delegate
extension PhotosViewController: PhotosViewModelDelegate {
    func didFailToLoadPhotosWithError(_ error: Error) {
        
    }
    
    func didUpdate(props: PhotosProps) {
        contentView.show(props: props)
    }
}

// MARK: - View Delegate
extension PhotosViewController: PhotosViewDelegate {
    func didChangeLayout(layoutType: LayoutType) {
        viewModel.changeLayout(layoutType)
    }
}
