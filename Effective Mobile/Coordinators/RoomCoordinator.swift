//
//  RoomCoordinator.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 13.01.2024.
//

import Foundation
import UIKit

protocol RoomCoordinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllersFactoryProtocol { get }
    
    func showReservationViewController()
}

class RoomCoordinatorFlow: RoomCoordinatorFlowProtocol {
    
    let navigationController: UINavigationController
    let viewControllerFactory: ViewControllersFactoryProtocol
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func showReservationViewController() {
        let reservationCoordinator = ReservationCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        reservationCoordinator.start(title: "Steigenberger Makadi")
    }
}


class RoomCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let viewContollerFactory: ViewControllersFactoryProtocol
    private let roomCoordinatorFlow: RoomCoordinatorFlow
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewContollerFactory = viewControllerFactory
        self.roomCoordinatorFlow = RoomCoordinatorFlow(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
    }
    
    func start() {
        let viewModel = RoomViewModel(title: "Steigenberger Makadi")
        viewModel.showReservation = roomCoordinatorFlow.showReservationViewController
        let roomViewController = viewContollerFactory.viewController(for: .room(viewModel: viewModel))
        navigationController.pushViewController(roomViewController, animated: true)
    }
}
