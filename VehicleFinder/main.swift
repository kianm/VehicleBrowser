//
//  main.swift
//  VehicleFinder
//
//  Created by kian on 8/25/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass =
    NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(appDelegateClass)
)
