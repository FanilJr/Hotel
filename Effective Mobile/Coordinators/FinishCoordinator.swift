//
//  FinishCoordinator.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 13.01.2024.
//

import Foundation
import UIKit

protocol FinishCoordinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllersFactoryProtocol { get }
    
    func showHotel()
}

class FinishCoordinatorFlow: FinishCoordinatorFlowProtocol {
    
     let navigationController: UINavigationController
     let viewControllerFactory: ViewControllersFactoryProtocol
     
     init(navigationController: UINavigationController,viewControllerFactory: ViewControllersFactoryProtocol) {
         self.navigationController = navigationController
         self.viewControllerFactory = viewControllerFactory
     }
    
    func showHotel() {
        let hotelCoordinator = HotelCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        hotelCoordinator.start()
    }
}

final class FinishCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let viewControllerFactory: ViewControllersFactoryProtocol
    private let finishCoordinatorFlow: FinishCoordinatorFlow
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        self.finishCoordinatorFlow = FinishCoordinatorFlow(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
    }
    
    func start() {
        let viewModel = FinishViewModel(title: "Заказ оплачен")
        viewModel.start = finishCoordinatorFlow.showHotel
        let viewController = viewControllerFactory.viewController(for: .finish(vieModel: viewModel))
        navigationController.pushViewController(viewController, animated: true)
    }
}
