//
//  ModuleRouterProtocol.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

/**
 Protocol for a module router.
 
 Use to operate routing between other module routers.
 */
protocol ModuleRouterProtocol: AnyObject {
    var flowRouter: FlowRouterProtocol? { get set }
    var viewController: UIViewController? { get set }
}
