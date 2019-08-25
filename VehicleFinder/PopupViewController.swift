//
//  PopupViewController.swift
//  VehicleFinder
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import UIKit
import VehicleModule

class PopupViewController: UIViewController {

    private let vehicle: Vehicle
    private let nameLabel = UILabel()
    private let batteryLabel = UILabel()
    private let priceLabel = UILabel()

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIScheme.popupBackgroundColor
        title = "Vehicle"
        setupUI()
        nameLabel.text = "Vehicle Name: \(vehicle.name)"
        batteryLabel.text = "Remaining Battery: \(vehicle.batteryLevel) %"
        priceLabel.text = "Price: \(vehicle.price) \(vehicle.currency)"
    }

    private func setupUI() {

        let views: [String: Any] = [
            "nameLabel": nameLabel,
            "batteryLabel": batteryLabel,
            "priceLabel": priceLabel]

        views.forEach { (_, value: Any) in
            guard let subView = value as? UIView else { return }
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        var constraints: [NSLayoutConstraint] = []

        constraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-12-[nameLabel]|",
            metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-12-[batteryLabel]|",
            metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-12-[priceLabel]|",
            metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-16-[nameLabel]-8-[batteryLabel]-8-[priceLabel]",
            metrics: nil, views: views)
        view.addConstraints(constraints)
    }
}
