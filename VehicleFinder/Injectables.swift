//
//  Injectables.swift
//  VehicleFinder
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation
import VehicleModule

struct InjectionMaps {
    static var vehicleClient: VehicleClientType = VehicleClient()
    static var popupInteractor: PopupInteractorType = PopupInteractor()
}

protocol VehicleClientInjected {}
extension VehicleClientInjected {
    public var vehicleClient: VehicleClientType { return InjectionMaps.vehicleClient}
}

protocol PopupInteractorInjected {}
extension PopupInteractorInjected {
    public var popupInteractor: PopupInteractorType { return InjectionMaps.popupInteractor}
}
