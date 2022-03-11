//
//  FlowRouterProtocol.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

/**
 Protocol for a specific application flow router.
 
 Use to operate flow router state and routing between module routers.
 */
protocol FlowRouterProtocol: AnyObject {
        
    var viewController: UIViewController { get }
    var appRouter: AppRouterProtocol { get }

    func startFlow(animated: Bool)
    func finishFlow(animated: Bool)
}
