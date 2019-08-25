//
//  Injectables.swift
//  VehicleModule
//
//  Created by kian on 8/23/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation

struct InjectionMaps {
    static var networking: NetworkingType = URLSession(configuration: APIConfiguration.urlSessionConfiguration)
}

protocol NetworkingInjected {}
extension NetworkingInjected {
    var networking: NetworkingType { return InjectionMaps.networking}
}
