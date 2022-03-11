//
//  ModuleBuilder.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

protocol ModuleBuilder {
    associatedtype Controller: UIViewController
    associatedtype ViewModel: Any
    associatedtype Router: ModuleRouterProtocol
    
    func build() -> Controller
}
