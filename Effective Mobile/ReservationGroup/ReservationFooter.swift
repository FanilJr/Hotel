//
//  ReservationFooter.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

protocol ReservationFooterProtocol: AnyObject {
    func getPayment()
}
class ReservationFooterView: UIView {
    
    weak var delegate: ReservationFooterProtocol?
    
    lazy var footerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    var titleForButton: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapButton() {
        delegate?.getPayment()
    }
    
    func layout() {
        [footerButton,titleForButton].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            footerButton.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            footerButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            footerButton.heightAnchor.constraint(equalToConstant: 45),
            footerButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            footerButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            
            titleForButton.centerYAnchor.constraint(equalTo: footerButton.centerYAnchor),
            titleForButton.centerXAnchor.constraint(equalTo: footerButton.centerXAnchor)
        ])
    }
    
    func setupFooter() {
        titleForButton.text = "Оплатить \(UserDefaults().string(forKey: "payment") ?? "")"
    }
}
