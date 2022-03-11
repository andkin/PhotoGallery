//
//  SplashViewController.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    weak var flowRouter: SplashFlowRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        flowRouter?.finishFlow(animated: true)
    }
}
