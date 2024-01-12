//
//  ReservationLastInfoViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

class ReservationLastInfoViewCell: UITableViewCell {
    
    var tourLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tourPrice: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fuelLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fuelPrice: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var serviceLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var servicePrice: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var paymentLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var paymentPrice: UILabel = {
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
        [tourLabel,tourPrice,fuelLabel,fuelPrice,serviceLabel,servicePrice,paymentLabel,paymentPrice].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            tourLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            tourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            tourPrice.centerYAnchor.constraint(equalTo: tourLabel.centerYAnchor),
            tourPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
        
            fuelLabel.topAnchor.constraint(equalTo: tourLabel.bottomAnchor,constant: 10),
            fuelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            fuelPrice.centerYAnchor.constraint(equalTo: fuelLabel.centerYAnchor),
            fuelPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
        
            serviceLabel.topAnchor.constraint(equalTo: fuelLabel.bottomAnchor,constant: 10),
            serviceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            servicePrice.centerYAnchor.constraint(equalTo: serviceLabel.centerYAnchor),
            servicePrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
        
            paymentLabel.topAnchor.constraint(equalTo: serviceLabel.bottomAnchor,constant: 10),
            paymentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            paymentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        
            paymentPrice.centerYAnchor.constraint(equalTo: paymentLabel.centerYAnchor),
            paymentPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20)])
    }
    
    func setupCell(reserv: Reserv) {
        tourLabel.text = "Тур"
        fuelLabel.text = "Топливный сбор"
        serviceLabel.text = "Сервисный сбор"
        paymentLabel.text = "К оплате"
        let formatterTour = NumberFormatter()
        formatterTour.numberStyle = .decimal
        formatterTour.maximumFractionDigits = 0
        formatterTour.groupingSeparator = " "
        let formatedNumberTour = formatterTour.string(from: NSNumber(value: reserv.tour_price)) ?? ""
        let attributedTour = NSMutableAttributedString(string: "\(formatedNumberTour) \u{20BD}")
        
        let formatterFuel = NumberFormatter()
        formatterFuel.numberStyle = .decimal
        formatterFuel.maximumFractionDigits = 0
        formatterFuel.groupingSeparator = " "
        let formatedNumberFuel = formatterFuel.string(from: NSNumber(value: reserv.fuel_charge)) ?? ""
        let attributedFuel = NSMutableAttributedString(string: "\(formatedNumberFuel) \u{20BD}")
        
        let formatterService = NumberFormatter()
        formatterService.numberStyle = .decimal
        formatterService.maximumFractionDigits = 0
        formatterService.groupingSeparator = " "
        let formatedService = formatterService.string(from: NSNumber(value: reserv.service_charge)) ?? ""
        let attributedService = NSMutableAttributedString(string: "\(formatedService) \u{20BD}")
        
        let summ = reserv.tour_price + reserv.fuel_charge + reserv.service_charge
        let formatterPayment = NumberFormatter()
        formatterPayment.numberStyle = .decimal
        formatterPayment.maximumFractionDigits = 0
        formatterPayment.groupingSeparator = " "
        let formatedPayment = formatterPayment.string(from: NSNumber(value: summ)) ?? ""
        let attributedPayment = NSMutableAttributedString(string: "\(formatedPayment) \u{20BD}")
        
        tourPrice.attributedText = attributedTour
        fuelPrice.attributedText = attributedFuel
        servicePrice.attributedText = attributedService
        paymentPrice.attributedText = attributedPayment
        
        UserDefaults().set(paymentPrice.text ?? "", forKey: "payment")
    }
}
