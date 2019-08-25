//
//  VehicleAnnotation.swift
//  VehicleFinder
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import MapKit

class VehicleAnnotation: MKPointAnnotation {

    let index: Int

    init(index: Int) {
        self.index = index
    }
}
