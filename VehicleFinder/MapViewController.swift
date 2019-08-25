//
//  MapViewController.swift
//  VehicleFinder
//
//  Created by kian on 8/21/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import UIKit
import VehicleModule
import RxSwift
import MapKit

class MapViewController: UIViewController {

    private let bag = DisposeBag()
    private let viewModel = MapViewModel()
    private let mapView = MKMapView(frame: .zero)
    private let selectedSubject = PublishSubject<Int>()
    private let deselectedSubject = PublishSubject<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIScheme.backgroundColor
        title = "Vehicles"
        bind(to: viewModel)
        setupUI()
    }

    func setupUI() {
        view.addAndFitSubView(mapView, inSafeArea: true)
        mapView.delegate = self
    }

}

extension MapViewController: ViewModelBindable {

    var disposeBag: DisposeBag? {
        return self.bag
    }

    func bind(to viewModel: MapViewModel) {

        let input = MapViewModel.Input(itemSelected: selectedSubject, itemDeselected: deselectedSubject)
        let output = viewModel.transform(input: input)
        output.vehicleCoords
            .subscribe(onNext: {[unowned self] (result: KMResult<[Coords]>) in
                switch result {
                case .success(let coords):
                    self.showVehicles(coords: coords)
                    self.zoomOnVehicles(coords: coords)
                case .failure(let error):
                    print(error)
                }
            })
        .disposed(by: bag)
    }

    private func showVehicles(coords: [Coords]) {
        var index = 0
        coords.forEach { coord in
            let annotation = VehicleAnnotation(index: index)
            annotation.coordinate = CLLocationCoordinate2D(latitude: coord.0, longitude: coord.1)
            mapView.addAnnotation(annotation)
            index += 1
        }
    }

    func zoomOnVehicles(coords: [Coords]) {

        let minLat = coords.min { a, b in a.0 < b.0 }!.0
        let minLon = coords.min { a, b in a.1 < b.1 }!.1
        let maxLat = coords.max { a, b in a.0 < b.0 }!.0
        let maxLon = coords.max { a, b in a.1 < b.1 }!.1

        let lat = 0.5 * (minLat + maxLat)
        let lon = 0.5 * (minLon + maxLon)
        let dLat = 3.0 * (maxLat - lat)
        let dLon = 3.0 * (maxLon - lon)

        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: dLat, longitudeDelta: dLon))
        mapView.setRegion(region, animated: true)
    }

}


extension MapViewController: MKMapViewDelegate {


    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? VehicleAnnotation else {
            return
        }
        selectedSubject.onNext(annotation.index)
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let index = (view.annotation as? VehicleAnnotation)?.index ?? -1
        deselectedSubject.onNext(index)
    }

}
