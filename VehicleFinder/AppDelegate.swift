//
//  AppDelegate.swift
//  VehicleFinder
//
//  Created by kian on 8/21/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: MapViewController())
        navigationController.navigationBar.barTintColor = UIScheme.backgroundColor
        window?.rootViewController = navigationController
        return true
    }
}

