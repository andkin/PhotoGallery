//
//  AppDelegate+Logger.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

final class AppDelegateLoggerPlugin: NSObject, AppDelegateService {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let lumberjackLogger = CocoaLumberjackLogger()
        Logger.shared = Logger([lumberjackLogger])
        
        Logger.verbose(.plugin, "Logger initialized. Writing to: \(lumberjackLogger)")
        return true
    }
}
