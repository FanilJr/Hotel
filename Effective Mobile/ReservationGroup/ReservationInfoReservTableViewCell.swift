//
//  ReservationInfoBuyerViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

class ReservationInfoReservTableViewCell: UITableViewCell {
    
    var flyFrom: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cityFrom: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var flyTo: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cityTo: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var date: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateString: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nightCount: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nightCountString: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var hotel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var hotelString: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var room: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var roomString: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var eat: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var eatString: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 20
        clipsToBounds = true
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [flyFrom,cityFrom,flyTo,cityTo,date,dateString,nightCount,nightCountString,hotel,hotelString,room,roomString,eat,eatString].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            flyFrom.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            flyFrom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            cityFrom.centerYAnchor.constraint(equalTo: flyFrom.centerYAnchor),
            cityFrom.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            flyTo.topAnchor.constraint(equalTo: flyFrom.bottomAnchor,constant: 10),
            flyTo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            cityTo.centerYAnchor.constraint(equalTo: flyTo.centerYAnchor),
            cityTo.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            date.topAnchor.constraint(equalTo: flyTo.bottomAnchor,constant: 10),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            dateString.centerYAnchor.constraint(equalTo: date.centerYAnchor),
            dateString.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nightCount.topAnchor.constraint(equalTo: date.bottomAnchor,constant: 10),
            nightCount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            nightCountString.centerYAnchor.constraint(equalTo: nightCount.centerYAnchor),
            nightCountString.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            hotel.topAnchor.constraint(equalTo: nightCount.bottomAnchor,constant: 10),
            hotel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            hotelString.centerYAnchor.constraint(equalTo: hotel.centerYAnchor),
            hotelString.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            room.topAnchor.constraint(equalTo: hotel.bottomAnchor,constant: 10),
            room.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            roomString.topAnchor.constraint(equalTo: room.topAnchor),
            roomString.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            roomString.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            eat.topAnchor.constraint(equalTo: roomString.bottomAnchor,constant: 10),
            eat.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            eat.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            
            eatString.centerYAnchor.constraint(equalTo: eat.centerYAnchor),
            eatString.leadingAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func setupCell(reserv: Reserv, title: String) {
        flyFrom.text = "Вылет из"
        cityFrom.text = reserv.departure
        flyTo.text = "Страна, город"
        cityTo.text = reserv.arrival_country
        date.text = "Даты"
        dateString.text = "\(reserv.tour_date_start)-\(reserv.tour_date_stop)"
        nightCount.text = "Кол-во ночей"
        nightCountString.text = "\(reserv.number_of_nights) ночей"
        hotel.text = "Отель"
        hotelString.text = title
        room.text = "Номер"
        roomString.text = reserv.room
        eat.text = "Питание"
        eatString.text = reserv.nutrition
    }
}
