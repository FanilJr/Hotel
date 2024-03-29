//
//  ReservViewModel.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 11.01.2024.
//

import Foundation

class ReservViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<Reserv> = Observable(nil)
    var dataSource: Reserv?
    var title: String
    var titleForCell: String
    var showFinish: (() -> Void)?
    
    enum Action {
        case showLast
    }
    
    init(title: String, titleForCell: String) {
        self.title = title
        self.titleForCell = titleForCell
    }
    
    func push(_ action: Action) {
        switch action {
        case .showLast:
            showFinish?()
        }
    }
    
    func getReservation() {
        isLoading.value = true
        
        Network.shared.getReservation { [weak self] reserv in
            guard let self else { return }
            self.dataSource = reserv
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
