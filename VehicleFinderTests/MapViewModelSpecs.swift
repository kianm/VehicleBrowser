//
//  MapViewModelSpecs.swift
//  VehicleFinderTests
//
//  Created by kian on 8/21/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import VehicleModule
@testable import VehicleFinder
import Nimble
import Quick
import RxSwift
import RxBlocking

class MapViewModelSpecs: QuickSpec {


    override func spec() {

        var viewModel: MapViewModel!
        var popupInteractor: PopupInteractorMock!

        beforeEach {
            InjectionMaps.vehicleClient = VehicleClientMock()
            popupInteractor = PopupInteractorMock()
            InjectionMaps.popupInteractor = popupInteractor
            viewModel = MapViewModel()
        }

        describe("MapViewModel Functionality") {

            context("upon subscribing") {
                it("should return coordinates of vehicles") {
                    let input = MapViewModel.Input(itemSelected: Observable.never(), itemDeselected: Observable.never())
                    let output = viewModel.transform(input: input)
                    let vehicleCoords = try! output.vehicleCoords.toBlocking().first()!.value!
                    vehicleCoords.forEach{ (lat: Double, lon: Double) in
                        expect(lat).to(beCloseTo(52.0, within: 1.0))
                        expect(lon).to(beCloseTo(13.0, within: 1.0))
                    }
                }
            }

            context("upon selecting i-th pin") {
                it("should present popup with i-th vehicle details") {
                    let subject = PublishSubject<Int>()
                    let input = MapViewModel.Input(itemSelected: subject, itemDeselected: Observable.never())
                    let output = viewModel.transform(input: input)
                    let _ = try! output.vehicleCoords.toBlocking().first()!.value!
                    subject.onNext(5)
                    expect(popupInteractor.vehicle!.name).to(equal("111111"))
                    expect(popupInteractor.vehicle!.batteryLevel).to(equal(88))
                }
            }

        }
    }
}

