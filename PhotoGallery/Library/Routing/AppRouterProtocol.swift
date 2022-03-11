//
//  AppRouterProtocol.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

/**
 Protocol for whole application routing.
 
 Use to route between predefiend flow routers.
 */
protocol AppRouterProtocol: AnyObject {
    
    var window: UIWindow? { get set }
    
    func present(flow: AppFlow, animated: Bool)

    var currentRouter: FlowRouterProtocol? { get set }
    var previousRouter: FlowRouterProtocol? { get set }
}

enum AppFlow {
    case splash
    case main
}
