//
//  RoomViewModel.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 10.01.2024.
//

import Foundation
import UIKit

class RoomViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<Rooms> = Observable(nil)
    var dataSource: Rooms?
    var title: String
    var showReservation: (() -> Void)?
    
    enum Action {
        case showReservation
    }
    
    init(title: String) {
        self.title = title
    }
    
    func push(_ action: Action) {
        switch action {
        case .showReservation:
            showReservation?()
        }
    }
    
    func getRooms() {
        isLoading.value = true
        
        Network.shared.getRooms { [weak self] rooms in
            guard let self else { return }
            self.dataSource = rooms
            self.mapCellData()
            self.isLoading.value = false
        } completionError: { error in
            self.isLoading.value = false
            print(error.localizedDescription)
        }
    }
    
    func mapCellData() {
        cellDataSource.value = dataSource
    }
}
