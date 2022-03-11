//
//  AppRouter.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

final class AppRouter: AppRouterProtocol {
    
    weak var window: UIWindow?
    
    var currentRouter: FlowRouterProtocol? { willSet { self.previousRouter = currentRouter } }
    var previousRouter: FlowRouterProtocol?
    
    func switchWindow(animated: Bool) {
        guard
            let window = self.window
            else {
                Logger.warning(.router, "UIWindow is undefined in: \(self)")
                return
        }
        
        window.rootViewController = self.currentRouter?.viewController
        
        if animated {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { },
                              completion: { _ in })
        }
        
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
}

extension AppRouter {
    func present(flow: AppFlow, animated: Bool) {
        switch flow {
        case .main:
            let router = MainFlowRouter(appRouter: self)
            self.currentRouter = router
            switchWindow(animated: animated)
            router.startFlow(animated: animated)
        }
    }
}
