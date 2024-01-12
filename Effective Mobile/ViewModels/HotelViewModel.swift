//
//  HotelViewModel.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 10.01.2024.
//

import Foundation
import UIKit

class HotelViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<Hotel> = Observable(nil)
    var dataSource: Hotel?
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func getHotel() {
        isLoading.value = true
        
        Network.shared.getHotel { [weak self] hotel in
            guard let self else { return }
            self.dataSource = hotel
            self.mapCellData()
            self.isLoading.value = false
        } completionError: { error in
            self.isLoading.value = false
            print(error)
        }
    }
    
    func mapCellData() {
        cellDataSource.value = dataSource
    }
}
