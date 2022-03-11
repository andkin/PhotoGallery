//
//  SplashFlowRouter.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

final class SplashFlowRouter: FlowRouterProtocol {
    
    lazy var viewController: UIViewController = {
        let splash = SplashViewController()
        splash.flowRouter = self
        return splash
    }()
    
    unowned let appRouter: AppRouterProtocol
    
    init(appRouter: AppRouterProtocol) {
        self.appRouter = appRouter
    }
    
    func startFlow(animated: Bool) {
        finishFlow(animated: animated)
    }
    
    func finishFlow(animated: Bool) {
        appRouter.present(flow: .main, animated: animated)
    }
}
