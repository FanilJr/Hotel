//
//  ReservationInfoAboutBuyerViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

class ReservationInfoAboutBuyerViewCell: UITableViewCell {
    
    var stackForPhone: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemGray6
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.spacing = 3
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        return stack
    }()
    
    var stackForMail: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemGray6
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.spacing = 3
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        return stack
    }()
    
    var infoAboutBuyerLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Информация о покупателе"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phonelabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Номер телефона"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textFieldPhone: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "+7 (***) ***-**-**"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.keyboardType = .numberPad
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    var mailLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Почта"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textFieldMail: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = "*****@***.com or .ru"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .systemGray6
        textfield.keyboardType = .emailAddress
        textfield.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return textfield
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 20
        clipsToBounds = true
        layout()
        apendStack()
        textFieldPhone.delegate = self
        textFieldMail.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [infoAboutBuyerLabel,stackForPhone,stackForMail,descriptionLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            infoAboutBuyerLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            infoAboutBuyerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            stackForPhone.topAnchor.constraint(equalTo: infoAboutBuyerLabel.bottomAnchor,constant: 10),
            stackForPhone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            stackForPhone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            stackForMail.topAnchor.constraint(equalTo: stackForPhone.bottomAnchor,constant: 10),
            stackForMail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            stackForMail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: stackForMail.bottomAnchor,constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
        ])
    }
    
    func apendStack() {
        [phonelabel,textFieldPhone].forEach { stackForPhone.addArrangedSubview($0) }
        [mailLabel,textFieldMail].forEach { stackForMail.addArrangedSubview($0) }
    }
}

extension ReservationInfoAboutBuyerViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textFieldPhone {
            if textField.text?.isEmpty == true {
                textFieldPhone.text = "+7"
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == textFieldPhone {
            if textField.text?.isEmpty == true || textField.text == "+" {
                textFieldPhone.text = "+7"
            } else {
                print("no")
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == textFieldPhone {
            guard let text = textField.text else { return }
            if text.count <= 11 {
                stackForPhone.layer.borderWidth = 0.2
                stackForPhone.layer.borderColor = UIColor.red.cgColor
            } else {
                stackForPhone.layer.borderWidth = 0
                stackForPhone.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textFieldPhone {
            guard let currentText = textField.text else { return true }

            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if updatedText.count <= 12 {
                return true
            } else {
                if updatedText.first == "9" {
                    let formattedText = "+7 " + updatedText.replacingOccurrences(of: "*", with: "9", options: .literal, range: updatedText.startIndex..<updatedText.index(updatedText.startIndex, offsetBy: 1))
                    textField.text = formattedText
                    return true
                }
                return false
            }
        } else {
            return true
        }
    }
}


