//
//  Data.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 09.01.2024.
//

import Foundation
import UIKit

struct Hotel: Decodable {
    var id: Int
    var name: String
    var adress: String
    var minimal_price: Int
    var price_for_it: String
    var rating: Int
    var rating_name: String
    var image_urls: [String]
    var about_the_hotel: AboutTheHotel
}

struct AboutTheHotel: Decodable {
    var description: String
    var peculiarities: [String]
}

struct Rooms: Decodable {
    var rooms: [Room]
}

struct Room: Decodable {
    var id: Int
    var name: String
    var price: Int
    var price_per: String
    var peculiarities: [String]
    var image_urls: [String]
}

struct Reserv: Decodable {
    var id: Int
    var hotel_name: String
    var hotel_adress: String
    var horating: Int
    var rating_name: String
    var departure: String
    var arrival_country: String
    var tour_date_start: String
    var tour_date_stop: String
    var number_of_nights: Int
    var room: String
    var nutrition: String
    var tour_price: Int
    var fuel_charge: Int
    var service_charge: Int
}

struct TableActions {
    var image: UIImage
    var title: String
    var description: String
    
    init(image: UIImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
    static func getTable() -> [TableActions] {
        var massive = [TableActions]()
        massive.append(TableActions(image: UIImage(systemName: "switch.programmable.square") ?? UIImage(), title: "Удобства", description: "Самое необходимое"))
        massive.append(TableActions(image: UIImage(systemName: "plus.app") ?? UIImage(), title: "Что включено", description: "Самое необходимое"))
        massive.append(TableActions(image: UIImage(named: "xmark.app") ?? UIImage(), title: "Что не включено", description: "Самое необходимое"))
        
        return massive
    }
}
