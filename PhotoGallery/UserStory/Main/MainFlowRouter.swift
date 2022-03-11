//
//  MainFlowRouter.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

final class MainFlowRouter: FlowRouterProtocol {
    
    var viewController: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    
    unowned let appRouter: AppRouterProtocol

    init(appRouter: AppRouterProtocol) {
        self.appRouter = appRouter
        self.navigationController = UINavigationController()
    }
    
    func startFlow(animated: Bool) {

    }
    
    func finishFlow(animated: Bool) {
        
    }
}
