//
//  PeculiaritiesCollectionViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 10.01.2024.
//

import Foundation
import UIKit

class PeculiaritiesCollectionViewCell: UICollectionViewCell {
    
    var details: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.backgroundColor = #colorLiteral(red: 0.9841945767, green: 0.9845693707, blue: 0.9880972505, alpha: 1)
        label.textColor = .systemGray2
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        contentView.addSubview(details)
        
        NSLayoutConstraint.activate([
            details.topAnchor.constraint(equalTo: contentView.topAnchor),
            details.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            details.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            details.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupPeculirities(peculiarities: String) {
        details.text = " \(peculiarities ) "
    }
}
