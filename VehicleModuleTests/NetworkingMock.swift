//
//  NetworkingMock.swift
//  VehicleModuleTests
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation
@testable import VehicleModule

typealias URLSessionCompletion = (Data?, URLResponse?, Error?) -> Void

final class MockURLSessionDataTask: URLSessionDataTask {

    private let completionHandler: URLSessionCompletion
    private let data: Data?
    private let errorStored: Error?

    init(_ completionHandler: @escaping URLSessionCompletion, _ data: Data?, _ error: Error?) {
        self.completionHandler = completionHandler
        self.data = data
        self.errorStored = error
    }

    override func resume() {
        completionHandler(data, nil, errorStored)
    }
}

class NetworkingMock: NetworkingType {

    private let data: Data?
    private let error: Error?

    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionCompletion) -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler, data, error)
    }
}

func sampleVehicleJSON() -> String {
    return "[\n  {\n    \"id\": 1,\n    \"name\": \"000011\",\n    \"description\": \"Electric Scooter\",\n    \"latitude\": 52.529077,\n    \"longitude\": 13.416351,\n    \"batteryLevel\": 98,\n    \"timestamp\": \"2019-03-10T09:31:56Z\",\n    \"price\": 15,\n    \"priceTime\": 60,\n    \"currency\": \"€\"\n  },\n  {\n    \"id\": 2,\n    \"name\": \"001100\",\n    \"description\": \"Electric Scooter\",\n    \"latitude\": 52.529103,\n    \"longitude\": 13.416255,\n    \"batteryLevel\": 11,\n    \"timestamp\": \"2019-03-10T11:15:22Z\",\n    \"price\": 20,\n    \"priceTime\": 60,\n    \"currency\": \"€\"\n  },\n  {\n    \"id\": 3,\n    \"name\": \"001111\",\n    \"description\": \"Electric Scooter\",\n    \"latitude\": 52.531478,\n    \"longitude\": 13.415641,\n    \"batteryLevel\": 69,\n    \"timestamp\": \"2019-03-10T19:55:56Z\",\n    \"price\": 15,\n    \"priceTime\": 60,\n    \"currency\": \"€\"\n  },\n  {\n    \"id\": 4,\n    \"name\": \"110000\",\n    \"description\": \"Electric Scooter\",\n    \"latitude\": 52.536722,\n    \"longitude\": 13.402195,\n    \"batteryLevel\": 3,\n    \"timestamp\": \"2019-03-11T09:31:56Z\",\n    \"price\": 15,\n    \"priceTime\": 60,\n    \"currency\": \"€\"\n  },\n  {\n    \"id\": 5,\n    \"name\": \"110011\",\n    \"description\": \"Electric Scooter\",\n    \"latitude\": 52.523395,\n    \"longitude\": 13.391886,\n    \"batteryLevel\": 45,\n    \"timestamp\": \"2019-03-10T09:14:52Z\",\n    \"price\": 20,\n    \"priceTime\": 60,\n    \"currency\": \"€\"\n  },\n  {\n    \"id\": 6,\n    \"name\": \"111111\",\n    \"description\": \"Electric Scooter\",\n    \"latitude\": 52.523395,\n    \"longitude\": 13.391386,\n    \"batteryLevel\": 88,\n    \"timestamp\": \"2019-03-10T12:18:52Z\",\n    \"price\": 15,\n    \"priceTime\": 60,\n    \"currency\": \"€\"\n  }\n]"
}
