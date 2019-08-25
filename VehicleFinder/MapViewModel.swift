//
//  MapViewModel.swift
//  VehicleFinder
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import RxSwift
import VehicleModule

typealias Coords = (Double, Double)

final class MapViewModel: ViewModelType, VehicleClientInjected, PopupInteractorInjected {

    private var vehicles: Vehicles?
    private let bag = DisposeBag()

    struct Input {
        let itemSelected: Observable<Int>
        let itemDeselected: Observable<Int>
    }

    struct Output {
        let vehicleCoords: Observable<KMResult<[Coords]>>
    }

    func transform(input: MapViewModel.Input) -> MapViewModel.Output {

        input.itemSelected
            .subscribe(onNext: {[unowned self] (index: Int) in
                guard let vehicle = self.vehicles?[index] else {
                    return
                }
                self.popupInteractor.present(vehicle: vehicle)
            })
            .disposed(by: bag)

        input.itemDeselected
            .subscribe(onNext: {[unowned self] (index: Int) in
                self.popupInteractor.dismiss()
            })
            .disposed(by: bag)

        let vehicles = vehicleClient.getVehicles().share()

        vehicles.subscribe(onNext: { (result: KMResult<[Vehicle]>) in
            switch result {
            case .success(let vehicles):
                self.vehicles = vehicles
            case .failure:
                self.vehicles = nil
            }
        })
            .disposed(by: bag)

        let coords = vehicles
            .observeOn(MainScheduler.instance)
            .map { (result: KMResult<[Vehicle]>) -> KMResult<[Coords]> in
                switch result {
                case .success(let vehicles):
                    return .success(vehicles.map{ (vehicle: Vehicle) -> Coords in
                        (vehicle.latitude, vehicle.longitude)
                    })
                case .failure(let error):
                    return .failure(error)
                }
        }

        return Output(vehicleCoords: coords)
    }
}
