//
//  AppDelegate.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        application.registerForRemoteNotifications()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LanchViewController()
        window?.makeKeyAndVisible()
        if UserInfoCenter.shared.loadValue(.iaped) == nil {
            UserInfoCenter.shared.storeValue(.iaped, data: 3)
        }
        return true
    }

}

