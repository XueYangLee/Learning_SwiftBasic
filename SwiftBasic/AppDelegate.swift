//
//  AppDelegate.swift
//  SwiftBasic
//
//  Created by 李雪阳 on 2024/3/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .white
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        
        return true
    }


}

