//
//  SceneDelegate.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

protocol SceneDelegateService: UIResponder, UIWindowSceneDelegate {}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - UISceneDelegate Services
    
    private lazy var services: [SceneDelegateService] = {
        return [
            SceneDelegateRouterPlugin()
        ]
    }()
    
    // MARK: - UISceneDelegate Lifecycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        services.forEach { $0.scene?(scene, willConnectTo: session, options: connectionOptions) }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        services.forEach { $0.sceneWillEnterForeground?(scene)}
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        services.forEach { $0.scene?(scene, openURLContexts: URLContexts) }
    }
}
