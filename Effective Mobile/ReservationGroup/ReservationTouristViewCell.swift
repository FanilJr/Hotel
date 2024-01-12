//
//  ReservationTouristViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

protocol ReservationTouristProtocol: AnyObject {
    func cellHeaderCoin(idx: Int)
}

class ReservationTouristViewCell: UITableViewCell {
    
    weak var delegate: ReservationTouristProtocol?
    var toogleHideImage : Bool = false
    var sectionIndex: Int?
    
    var touristLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hideCell), for: .touchUpInside)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .createColor(light: .black, dark: .white)
        return button
    }()
    
    var stackForTourist: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.spacing = 10
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        return stack
    }()
    
    var nameTextfield: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "Иван"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.keyboardType = .emailAddress
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingPoints(15)
        textfield.clipsToBounds = true
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    var secondNameTextfield: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "Иванов"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingPoints(15)
        textfield.keyboardType = .emailAddress
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    var birthdayTextfield: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "Дата рождения "
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingPoints(15)
        textfield.keyboardType = .emailAddress
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    var countryTextfield: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "Гражданство"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingPoints(15)
        textfield.keyboardType = .emailAddress
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    var numberPasportTextfield: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "Номер загранпаспорта"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingPoints(15)
        textfield.keyboardType = .emailAddress
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    var datePasportTextfield: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "Срок действия загранпаспорта"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingPoints(15)
        textfield.keyboardType = .emailAddress
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 20
        clipsToBounds = true
        stackAppend()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func hideCell() {
        toogleHideImage.toggle()
        if toogleHideImage {
            hideButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            hideButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        guard let sectionIndex else { return }
        delegate?.cellHeaderCoin(idx: sectionIndex)
    }
    
    func layout() {
        [touristLabel,hideButton,stackForTourist].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            touristLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            touristLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            touristLabel.heightAnchor.constraint(equalToConstant: 40),
            
            hideButton.centerYAnchor.constraint(equalTo: touristLabel.centerYAnchor),
            hideButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            hideButton.widthAnchor.constraint(equalToConstant: 25),
            hideButton.heightAnchor.constraint(equalToConstant: 25),
            
            stackForTourist.topAnchor.constraint(equalTo: touristLabel.bottomAnchor),
            stackForTourist.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            stackForTourist.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            stackForTourist.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
        ])
    }
    
    func stackAppend() {
        [nameTextfield,secondNameTextfield,birthdayTextfield,countryTextfield,numberPasportTextfield,datePasportTextfield].forEach { stackForTourist.addArrangedSubview($0) }
        nameTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        secondNameTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        birthdayTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        countryTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        numberPasportTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        datePasportTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
