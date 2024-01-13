//
//  ReservationCoordinator.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 13.01.2024.
//

import Foundation
import UIKit

protocol ReservationCoorinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllersFactoryProtocol { get }
    
    func showFinishViewController()
}

class ReservationCoordinatorFlow: ReservationCoorinatorFlowProtocol {
    
     let navigationController: UINavigationController
     let viewControllerFactory: ViewControllersFactoryProtocol
     
     init(navigationController: UINavigationController,viewControllerFactory: ViewControllersFactoryProtocol) {
         self.navigationController = navigationController
         self.viewControllerFactory = viewControllerFactory
     }
    
    func showFinishViewController() {
        let finishCoordinator = FinishCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        finishCoordinator.start()
    }
}

final class ReservationCoordinator: Coordinator {
    func start() {
        print("start")
    }
    
    private let navigationController: UINavigationController
    private let viewControllerFactory: ViewControllersFactoryProtocol
    private let reservationCoordinatorFlow: ReservationCoordinatorFlow
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        self.reservationCoordinatorFlow = ReservationCoordinatorFlow(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
    }
    
    func start(title: String) {
        let viewModel = ReservViewModel(title: "Бронирование", titleForCell: title)
        viewModel.showFinish = reservationCoordinatorFlow.showFinishViewController
        let viewcontroller = viewControllerFactory.viewController(for: .reserv(viewModel: viewModel))
        navigationController.pushViewController(viewcontroller, animated: true)
    }
}
