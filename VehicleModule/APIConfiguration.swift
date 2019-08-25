//
//  APIConfiguration.swift
//  VehicleModule
//
//  Created by kian on 8/23/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation

struct APIConfiguration {
    static let urlSessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        configuration.urlCache?.memoryCapacity = 0
        configuration.urlCache?.diskCapacity = 0
        return configuration
    }()
}

