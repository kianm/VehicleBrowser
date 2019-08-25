//
//  APIClientSpecs.swift
//  VehicleModuleTests
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

@testable import VehicleModule
import Nimble
import Quick
import RxSwift
import RxBlocking

class APIClientSpecs: QuickSpec {


    override func spec() {
        var client: VehicleClient!

        func setupClient(_ data: Data?, _ error: Error?) {
            let networking = NetworkingMock(data: data, error: error)
            client = VehicleClient()
            InjectionMaps.networking = networking
        }

        describe("APIClient Vehicle Retrieval") {


            context("upon calling") {
                it("should return success with list of vehicles") {
                    setupClient(sampleVehicleJSON().data(using: .utf8)!, nil)
                    let vehicles = try! client.getVehicles().toBlocking().first()!
                    expect(vehicles.value?.count).to(equal(6))
                }
            }

            context("upon server error") {
                it("should return failure with nil data and non-nil error") {
                    setupClient(nil, KMErrorType.noInternetConnection)
                    let vehicles = try! client.getVehicles().toBlocking().first()!
                    let error = vehicles.error as! KMErrorType
                    expect(error).to(equal(KMErrorType.noInternetConnection))
                }
            }

            context("upon server error") {
                it("should return failure with nil data and nil error") {
                    setupClient(nil, nil)
                    let vehicles = try! client.getVehicles().toBlocking().first()!
                    let error = vehicles.error as! KMErrorType
                    expect(error).to(equal(KMErrorType.serverError(500)))
                }
            }

        }
    }
}
