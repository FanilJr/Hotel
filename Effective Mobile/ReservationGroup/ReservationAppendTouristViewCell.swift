//
//  ReservationAppendTouristViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import Foundation
import UIKit

protocol ReservationAppendProtocol: AnyObject {
    func apendUser()
}
class ReservationAppendTouristViewCell: UITableViewCell {
    
    weak var delegate: ReservationAppendProtocol?
    
    var touristLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Добавить туриста"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(plusTourist), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .createColor(light: .black, dark: .white)
        return button
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
    
    @objc func plusTourist() {
        delegate?.apendUser()
    }
    
    func layout() {
        [touristLabel,plusButton].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            touristLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            touristLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            touristLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            
            plusButton.centerYAnchor.constraint(equalTo: touristLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            plusButton.widthAnchor.constraint(equalToConstant: 25),
            plusButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
