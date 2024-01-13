//
//  ViewController.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 09.01.2024.
//

import UIKit

class HotelViewController: UIViewController {

    var hotel: Hotel?
    var footerView = HotelFooterView()
    let hotelViewModel: HotelViewModel
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityView.color = .createColor(light: .black, dark: .white)
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alpha = 0.1
        tableView.backgroundColor = .systemGray6
        tableView.register(HotelHeaderCell.self, forCellReuseIdentifier: "HotelHeaderCell")
        tableView.register(HotelTableViewCell.self, forCellReuseIdentifier: "HotelTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = hotelViewModel.title
        layout()
    }
    
    init(hotelViewModel: HotelViewModel) {
        self.hotelViewModel = hotelViewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        hotelViewModel.getHotel()
        hotelViewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
        hotelViewModel.cellDataSource.bind { [weak self] hotel in
            guard let self, let hotel else { return }
            self.hotel = hotel
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.tableView.alpha = 1
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func layout() {
        footerView.delegate = self
        [tableView,activityIndicator].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HotelViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension HotelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HotelHeaderCell", for: indexPath) as! HotelHeaderCell
            if let hotel = hotel {
                cell.setupHeader(hotel: hotel)
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HotelTableViewCell", for: indexPath) as! HotelTableViewCell
            if let hotel = hotel {
                cell.setupInfo(hotel: hotel)
                cell.hotel = hotel
            }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            return CustomHeaderView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return footerView
        default:
            return nil
        }
    }
}

extension HotelViewController: HotelFooterProtocol {
    func openRoom() {
        hotelViewModel.push(.showRoomViewController)
    }
}

