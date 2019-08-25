//
//  PopupInteractor.swift
//  VehicleFinder
//
//  Created by kian on 8/24/19.
//  Copyright © 2019 Kisn. All rights reserved.
//

import Foundation
import VehicleModule

protocol PopupInteractorType {
    func present(vehicle: Vehicle)
    func dismiss()
}

class PopupInteractor: PopupInteractorType {

    var popupVC: UIViewController?

    func present(vehicle: Vehicle) {
        let topViewController = UIApplication.topViewController()!
        let popupVC = PopupViewController(vehicle: vehicle)
        topViewController.addChild(popupVC)
        guard let containerView = topViewController.view else {
            return
        }
        popupVC.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(popupVC.view)
        popupVC.didMove(toParent: topViewController)
        containerView.addConstraints([
            NSLayoutConstraint(item: popupVC.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popupVC.view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popupVC.view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
            ])
        popupVC.view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.popupVC = popupVC
    }

    func dismiss() {
        popupVC?.willMove(toParent: nil)
        popupVC?.view.removeFromSuperview()
        popupVC?.removeFromParent()
        popupVC = nil
    }
}
