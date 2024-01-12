//
//  HeaderTableView.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 09.01.2024.
//

import Foundation
import UIKit

class HotelHeaderCell: UITableViewCell {
    
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
    
    var priceLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 33)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        clipsToBounds = true
        backgroundColor = .systemBackground
        scrollView.delegate = self
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pageChange() {
        scrollToIndex(index: pageControl.currentPage)
    }
    
    func setupHeader() {
        contentView.addSubview(scrollView)
        [backgroundForPage,pageControl,ratingLabel,nameHotelLabel,hotelAdressLabel,priceLabel].forEach { contentView.addSubview($0) }
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
            
            ratingLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor,constant: 40),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            ratingLabel.heightAnchor.constraint(equalToConstant: 25),
            ratingLabel.widthAnchor.constraint(equalToConstant: 155),
            
            nameHotelLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor,constant: 10),
            nameHotelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            
            hotelAdressLabel.topAnchor.constraint(equalTo: nameHotelLabel.bottomAnchor),
            hotelAdressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            
            priceLabel.topAnchor.constraint(equalTo: hotelAdressLabel.bottomAnchor,constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
        ])
    }
    
    func setupHeader(hotel: Hotel) {
        self.ratingLabel.text = "★ \(hotel.rating) \(hotel.rating_name)"
        configureScroll(scroll: self.scrollView, pageControl: self.pageControl, with: hotel.image_urls)
        self.nameHotelLabel.text = "Steigenberger Makadi"
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = " "
        let formatedNumber = formatter.string(from: NSNumber(value: hotel.minimal_price)) ?? ""
        let attributedString = NSMutableAttributedString(string: "от \(formatedNumber) \u{20BD}")

        let additionalText = NSAttributedString(string: " \(hotel.price_for_it)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        attributedString.append(additionalText)
        self.priceLabel.attributedText = attributedString
        self.hotelAdressLabel.text = hotel.adress
    }
    
    private func scrollToIndex(index: Int) {
        let pageWidth: CGFloat = scrollView.frame.width
        let slideToX: CGFloat = CGFloat(index) * pageWidth
        scrollView.scrollRectToVisible(CGRect(x: slideToX, y:0, width:pageWidth, height:scrollView.frame.height), animated: true)
    }
}

extension HotelHeaderCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        pageControl.currentPage = Int(currentPage)
    }
}
