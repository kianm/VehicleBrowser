//
//  VehicleClientType.swift
//  VehicleModule
//
//  Created by kian on 8/21/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import RxSwift

public protocol VehicleClientType: class {
    func getVehicles() -> Observable<KMResult<[Vehicle]>>
}
