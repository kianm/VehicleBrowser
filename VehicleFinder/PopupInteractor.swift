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
        popupVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -36).isActive = true
        popupVC.view.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        popupVC.view.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
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
