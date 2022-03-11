//
//  AppDelegate.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit
import SnapKit

protocol AppDelegateService: UIApplicationDelegate, UNUserNotificationCenterDelegate {}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    // MARK: - UIApplicationDelegate Services
    private lazy var services: [AppDelegateService] = {
        return [
            AppDelegateLaunchTime(.start),
            AppDelegateLoggerPlugin(),
            AppDelegateLaunchTime(.finish)
        ]
    }()
    
    // MARK: - UIApplicationDelegate Lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var result = false
        for service in services {
            if service.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? false {
                result = true
            }
        }
        return result
    }

    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        var configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        for service in services {
            if let sceneConfiguration = service.application?(application,
                                                             configurationForConnecting: connectingSceneSession,
                                                             options: options) {
                configuration = sceneConfiguration
            }
        }
        return configuration
    }
}
