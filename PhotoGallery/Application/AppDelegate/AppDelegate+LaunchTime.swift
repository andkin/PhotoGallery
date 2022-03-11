//
//  AppDelegate+LaunchTime.swift
//  PhotoGallery
//
//  Created by Andrii Kindrat on 11.03.2022.
//

import UIKit

final class AppDelegateLaunchTime: NSObject, AppDelegateService {
    
    enum LaunchType {
        case start
        case finish
    }

    private static var launchTime: CFAbsoluteTime!

    private let shallMeasureExecutionTime: Bool

    init(_ type: LaunchType) {
        shallMeasureExecutionTime = type == .finish
        super.init()
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        if shallMeasureExecutionTime {
            let currentTime = CFAbsoluteTimeGetCurrent()
            let totalTimeSpent = currentTime - AppDelegateLaunchTime.launchTime
            Logger.info(.plugin, "Plugins initialization took \(totalTimeSpent) seconds")
        } else {
            AppDelegateLaunchTime.launchTime = CFAbsoluteTimeGetCurrent()
        }
        return true
    }
}
