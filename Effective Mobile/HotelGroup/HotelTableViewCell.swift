//
//  InfoAboutHotelCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 09.01.2024.
//

import Foundation
import UIKit

class HotelTableViewCell: UITableViewCell {
    
    var hotel: Hotel? {
        didSet {
            guard let hotel else { return }
            self.massiveCollection = hotel.about_the_hotel.peculiarities
            DispatchQueue.main.async {
                self.collectionViews.reloadData()
            }
        }
    }
    
    var massiveCollection = [String]()
    var massiveTableView = TableActions.getTable()
    
    var infoHotel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.fixedSpacedFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PeculiaritiesCollectionViewCell.self, forCellWithReuseIdentifier: "PeculiaritiesCollectionViewCell")
        return collectionView
    }()
    
    var infoAboutHotel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 7
        tableView.isScrollEnabled = false
        tableView.register(HotelTableInInfoTableViewCell.self, forCellReuseIdentifier: "HotelTableInInfoTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    func setupInfo(hotel: Hotel) {
        infoHotel.text = "Об отеле"
        infoAboutHotel.text = hotel.about_the_hotel.description
    }
    
    func layout() {
        [infoHotel,collectionViews,infoAboutHotel,tableView].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            infoHotel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            infoHotel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
        
            collectionViews.topAnchor.constraint(equalTo: infoHotel.bottomAnchor,constant: 10),
            collectionViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            collectionViews.heightAnchor.constraint(equalToConstant: 70),
            collectionViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            infoAboutHotel.topAnchor.constraint(equalTo: collectionViews.bottomAnchor,constant: 10),
            infoAboutHotel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            infoAboutHotel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            tableView.topAnchor.constraint(equalTo: infoAboutHotel.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        ])
    }
}

extension HotelTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massiveCollection.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeculiaritiesCollectionViewCell", for: indexPath) as! PeculiaritiesCollectionViewCell
        cell.clipsToBounds = true
        cell.setupPeculirities(peculiarities: massiveCollection[indexPath.row])
        return cell
    }
}

extension UICollectionViewFlowLayout {
    
    static func fixedSpacedFlowLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8), top: .fixed(4), trailing: .fixed(8), bottom: .fixed(4))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension HotelTableViewCell: UICollectionViewDelegateFlowLayout {
    
}

extension HotelTableViewCell: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HotelTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massiveTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelTableInInfoTableViewCell", for: indexPath) as! HotelTableInInfoTableViewCell
        cell.setupTable(massiveTable: massiveTableView[indexPath.row])
        cell.selectionStyle = .none
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 7
        cell.backgroundColor = .systemGray6
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

