//
//  PhotosRouter.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

protocol PhotosVCRoutingProtocol {
    
}

protocol PhotosVCPresentingProtocol: AnyObject {
    func showPhotosViewController(animated: Bool)
}

class PhotosRouter: ModuleRouterProtocol {
    
    weak var flowRouter: FlowRouterProtocol?
    weak var viewController: UIViewController?
    
    var navigationController: UINavigationController? {
        return viewController?.navigationController
    }
}

extension PhotosRouter: PhotosVCRoutingProtocol {
    
}
