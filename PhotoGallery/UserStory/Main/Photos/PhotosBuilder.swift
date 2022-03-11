//
//  PhotosBuilder.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import Foundation

class PhotosBuilder: ModuleBuilder {
    typealias Controller = PhotosViewController
    typealias ViewModel = PhotosViewModel
    typealias Router = PhotosRouter
    
    private weak var flowRouter: FlowRouterProtocol?
    
    init(flowRouter: FlowRouterProtocol?) {
        self.flowRouter = flowRouter
    }
    
    func build() -> PhotosViewController {
        let router = Router()
        let viewModel = ViewModel()
        let viewController = Controller(viewModel: viewModel,
                                        router: router)
        router.viewController = viewController
        router.flowRouter = flowRouter
        return viewController
    }
}
