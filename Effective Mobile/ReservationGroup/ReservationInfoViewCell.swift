//
//  ReservationInfoViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

class ReservationInfoViewCell: UITableViewCell {
    
    var ratingLabel: UILabel = {
        var label = UILabel()
        label.textColor = #colorLiteral(red: 0.9628155828, green: 0.6576111913, blue: 0.1939643323, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.9992174506, green: 0.9569595456, blue: 0.8004327416, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 16)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nameHotelLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var hotelAdressLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        label.textColor = #colorLiteral(red: 0.06463696808, green: 0.4443169236, blue: 0.9848815799, alpha: 1)
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
        [ratingLabel,nameHotelLabel,hotelAdressLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            nameHotelLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor,constant: 10),
            nameHotelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            hotelAdressLabel.topAnchor.constraint(equalTo: nameHotelLabel.bottomAnchor),
            hotelAdressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            hotelAdressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
        ])
    }
    
    func setupCell(reserv: Reserv, title: String) {
        ratingLabel.text = "★ \(reserv.horating) \(reserv.rating_name)"
        nameHotelLabel.text = title
        hotelAdressLabel.text = reserv.hotel_adress
    }
}
