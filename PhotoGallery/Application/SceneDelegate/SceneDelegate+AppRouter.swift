//
//  SceneDelegate+AppRouter.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

final class SceneDelegateRouterPlugin: UIResponder, SceneDelegateService {

    var window: UIWindow?
    private var router: AppRouterProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
                
        router = AppRouter()
        
        router?.window = window
        router?.present(flow: .splash, animated: true)
        
        Logger.verbose(.plugin, "Application Router is ready. Presenting launch screen...")
    }
}
