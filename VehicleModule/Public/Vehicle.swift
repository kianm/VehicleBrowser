//
//  Vehicle.swift
//  VehicleModule
//
//  Created by kian on 8/23/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation

public struct Vehicle: Decodable {
    public let name: String
    public let description: String
    public let latitude: Double
    public let longitude: Double
    public let batteryLevel: Int
    public let timestamp: Date
    public let price: Float
    public let priceTime: Float
    public let currency: String
}

public typealias Vehicles = [Vehicle]
