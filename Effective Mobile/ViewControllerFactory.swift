//
//  ViewControllerFactory.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

enum TypeViewController {
    case hotel(viewModel: HotelViewModel)
    case room(viewModel: RoomViewModel)
    case reserv(viewModel: ReservViewModel)
    case finish(vieModel: FinishViewModel)
    
    func makeViewController() -> UIViewController {
        switch self {
        case .hotel(viewModel: let viewModel):
            return HotelViewController(hotelViewModel: viewModel)
        case .room(viewModel: let viewModel):
            return RoomInfoViewController(roomViewModel: viewModel)
        case .reserv(viewModel: let viewModel):
            return ReservationViewController(reservViewModel: viewModel, titleForCell: "")
        case .finish(vieModel: let viewModel):
            return FinishViewController(finishViewModel: viewModel)
        }
    }
}

protocol ViewControllersFactoryProtocol {
    func viewController(for typeViewController: TypeViewController) -> UIViewController
}

final class ViewControllerFactory: ViewControllersFactoryProtocol {
    func viewController(for typeViewController: TypeViewController) -> UIViewController {
        return typeViewController.makeViewController()
    }
}
