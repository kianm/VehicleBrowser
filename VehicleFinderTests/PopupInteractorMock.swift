//
//  PopupInteractorMock.swift
//  VehicleFinderTests
//
//  Created by kian on 8/25/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation
@testable import VehicleFinder
import VehicleModule

class PopupInteractorMock: PopupInteractorType {

    var vehicle: Vehicle?

    func present(vehicle: Vehicle) {
        self.vehicle = vehicle
    }

    func dismiss() {

    }

}
