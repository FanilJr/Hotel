//
//  ButtonTableViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 10.01.2024.
//

import Foundation
import UIKit

class HotelTableInInfoTableViewCell: UITableViewCell {
    
    var imageLeft: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        return image
    }()
    
    var imageRight: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        [titleLabel,descriptionLabel,imageLeft,imageRight].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 50),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            
            imageLeft.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageLeft.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            imageLeft.widthAnchor.constraint(equalToConstant: 25),
            imageLeft.heightAnchor.constraint(equalToConstant: 25),
            
            imageRight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            imageRight.widthAnchor.constraint(equalToConstant: 25),
            imageRight.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupTable(massiveTable: TableActions) {
        titleLabel.text = massiveTable.title
        descriptionLabel.text = massiveTable.description
        imageLeft.image = massiveTable.image
        imageRight.image = UIImage(systemName: "chevron.forward")
    }
}
