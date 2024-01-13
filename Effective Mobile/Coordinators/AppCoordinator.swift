//
//  AppCoordinator.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator, Coordinator {
    private let viewControllerFactory: ViewControllersFactoryProtocol
    private var window: UIWindow?
    private let scene: UIWindowScene
    
    init(scene: UIWindowScene, viewControllerFactory: ViewControllersFactoryProtocol) {
        self.scene = scene
        self.viewControllerFactory = viewControllerFactory
        super.init()
    }
    
    func start() {
        initWindow()
    }
    
    private func initWindow() {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = settingsViewController().first
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func settingsViewController() -> [UINavigationController] {
        let viewModel = HotelViewModel(title: "Отель")
        let hotelViewController = viewControllerFactory.viewController(for: .hotel(viewModel: viewModel))
        let navigationHotelViewController = createNavController(for: hotelViewController, title: viewModel.title)
        let hotelCoordinator = HotelCoordinator(navigationController: navigationHotelViewController, viewControllerFactory: viewControllerFactory)
        addDependency(hotelCoordinator)
        hotelCoordinator.start()
        return [navigationHotelViewController]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        return navController
    }
}
