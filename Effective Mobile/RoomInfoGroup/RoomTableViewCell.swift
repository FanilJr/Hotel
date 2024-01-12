//
//  RoomTableViewCell.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 11.01.2024.
//

import Foundation
import UIKit

protocol RoomTableProtocol: AnyObject {
    func goInBronirovanie()
}
class RoomTableViewCell: UITableViewCell {
    
    weak var delegate: RoomTableProtocol?
    var room: Room? {
        didSet {
            guard let room else { return }
            DispatchQueue.main.async {
                configureScroll(scroll: self.scrollView, pageControl: self.pageControl, with: room.image_urls)
            }
        }
    }
    
    var backgroundForPage: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = .black
        control.currentPage = 0
        control.addTarget(self, action: #selector(pageChange), for: .valueChanged)
        return control
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.clipsToBounds = true
        scroll.layer.cornerRadius = 15
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
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
    
    let moreInfoAboutRoom: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.text = "Подробнее о номере"
        label.font = UIFont(name: "Arial", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageRight: UIImageView = {
        let image = UIImageView()
        image.tintColor = .systemBlue
        image.image = UIImage(systemName: "chevron.forward")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var backForMoreInfo: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.906806767, green: 0.9462431073, blue: 0.9970073104, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()
    
    var priceLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var chooseRoomButton: UIButton = {
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
        label.text = "Выбрать номер"
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 20
        clipsToBounds = true
        scrollView.delegate = self
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapButton() {
        delegate?.goInBronirovanie()
    }
    
    func setupRoom(room: Room) {
        self.descriptionLabel.text = room.name
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = " "
        let formatedNumber = formatter.string(from: NSNumber(value: room.price)) ?? ""
        let attributedString = NSMutableAttributedString(string: "от \(formatedNumber) \u{20BD}")

        let additionalText = NSAttributedString(string: " \(room.price_per)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        attributedString.append(additionalText)
        self.priceLabel.attributedText = attributedString
    }
    
    func layout() {
        contentView.addSubview(scrollView)
        [backgroundForPage,pageControl,descriptionLabel,collectionViews,backForMoreInfo,moreInfoAboutRoom,imageRight,priceLabel,chooseRoomButton,titleForButton].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            scrollView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant: -30),
            scrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20),
            pageControl.heightAnchor.constraint(equalToConstant: 5),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            backgroundForPage.topAnchor.constraint(equalTo: pageControl.topAnchor,constant: -7),
            backgroundForPage.leadingAnchor.constraint(equalTo: pageControl.leadingAnchor,constant: 28),
            backgroundForPage.trailingAnchor.constraint(equalTo: pageControl.trailingAnchor,constant: -28),
            backgroundForPage.bottomAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: 7),
            
            descriptionLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            collectionViews.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            collectionViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            collectionViews.heightAnchor.constraint(equalToConstant: 60),
            collectionViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            
            backForMoreInfo.topAnchor.constraint(equalTo: collectionViews.bottomAnchor),
            backForMoreInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            backForMoreInfo.widthAnchor.constraint(equalToConstant: 150),
            backForMoreInfo.heightAnchor.constraint(equalToConstant: 25),
            
            moreInfoAboutRoom.centerYAnchor.constraint(equalTo: backForMoreInfo.centerYAnchor),
            moreInfoAboutRoom.leadingAnchor.constraint(equalTo: backForMoreInfo.leadingAnchor,constant: 10),
            
            imageRight.centerYAnchor.constraint(equalTo: moreInfoAboutRoom.centerYAnchor),
            imageRight.trailingAnchor.constraint(equalTo: backForMoreInfo.trailingAnchor,constant: -5),
            imageRight.widthAnchor.constraint(equalToConstant: 17),
            imageRight.heightAnchor.constraint(equalToConstant: 17),
            
            priceLabel.topAnchor.constraint(equalTo: imageRight.bottomAnchor,constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            chooseRoomButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,constant: 20),
            chooseRoomButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            chooseRoomButton.heightAnchor.constraint(equalToConstant: 45),
            chooseRoomButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            chooseRoomButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            
            titleForButton.centerYAnchor.constraint(equalTo: chooseRoomButton.centerYAnchor),
            titleForButton.centerXAnchor.constraint(equalTo: chooseRoomButton.centerXAnchor)
        ])
    }
    
    @objc func pageChange() {
        scrollToIndex(index: pageControl.currentPage)
    }
    
    private func scrollToIndex(index: Int) {
        let pageWidth: CGFloat = scrollView.frame.width
        let slideToX: CGFloat = CGFloat(index) * pageWidth
        scrollView.scrollRectToVisible(CGRect(x: slideToX, y:0, width:pageWidth, height:scrollView.frame.height), animated: true)
    }
}

extension RoomTableViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        pageControl.currentPage = Int(currentPage)
    }
}

extension RoomTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return room?.peculiarities.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeculiaritiesCollectionViewCell", for: indexPath) as! PeculiaritiesCollectionViewCell
        cell.clipsToBounds = true
        cell.setupPeculirities(peculiarities: room?.peculiarities[indexPath.row] ?? String())
        return cell
    }
}

extension RoomTableViewCell {
    
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

extension RoomTableViewCell: UICollectionViewDelegateFlowLayout {
    
}
