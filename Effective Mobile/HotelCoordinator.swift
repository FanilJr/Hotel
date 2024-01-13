//
//  HotelCoordinator.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import UIKit

protocol HotelCoordinatorFlowProtocol {
    var navigationController: UINavigationController { get }
    var viewControllerFactory: ViewControllersFactoryProtocol { get }
    
    func showRoomViewController()
}

class HotelCoordinatorFlow: HotelCoordinatorFlowProtocol {
    
     let navigationController: UINavigationController
     let viewControllerFactory: ViewControllersFactoryProtocol
     
     init(navigationController: UINavigationController,viewControllerFactory: ViewControllersFactoryProtocol) {
         self.navigationController = navigationController
         self.viewControllerFactory = viewControllerFactory
     }
    
    func showRoomViewController() {
        let roomCoordinator = RoomCoordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
        roomCoordinator.start()
    }
}

final class HotelCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let viewControllerFactory: ViewControllersFactoryProtocol
    private let hotelCoordinatorFlow: HotelCoordinatorFlow
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        self.hotelCoordinatorFlow = HotelCoordinatorFlow(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
    }
    
    func start() {
        let viewModel = HotelViewModel(title: "Отель")
        viewModel.showRoom = hotelCoordinatorFlow.showRoomViewController
        let viewcontroller = viewControllerFactory.viewController(for: .hotel(viewModel: viewModel))
        navigationController.setViewControllers([viewcontroller], animated: false)
    }
}
