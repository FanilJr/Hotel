//
//  ReservationViewController.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 11.01.2024.
//

import UIKit

class ReservationViewController: UIViewController {

    var reserv: Reserv?
    var titleForCell: String?
    let reservViewModel: ReservViewModel
    var footerView = ReservationFooterView()
    var toogleTourist: Bool = true
    var users = ["Первый турист"]
    var index: Int?
    var section: Int?
    
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
        tableView.backgroundColor = .systemGray6
        tableView.register(ReservationInfoViewCell.self, forCellReuseIdentifier: "ReservationInfoViewCell")
        tableView.register(ReservationInfoReservTableViewCell.self, forCellReuseIdentifier: "ReservationInfoReservTableViewCell")
        tableView.register(ReservationInfoAboutBuyerViewCell.self, forCellReuseIdentifier: "ReservationInfoAboutBuyerViewCell")
        tableView.register(ReservationTouristViewCell.self, forCellReuseIdentifier: "ReservationTouristViewCell")
        tableView.register(ReservationAppendTouristViewCell.self, forCellReuseIdentifier: "ReservationAppendTouristViewCell")
        tableView.register(ReservationLastInfoViewCell.self, forCellReuseIdentifier: "ReservationLastInfoViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if let previousViewController = navigationController?.viewControllers.dropLast().last {
            previousViewController.title = ""
        }
        layout()
        footerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = reservViewModel.title
    }
    
    init(reservViewModel: ReservViewModel) {
        self.reservViewModel = reservViewModel
        self.titleForCell = reservViewModel.titleForCell
        super.init(nibName: nil, bundle: nil)
        self.title = reservViewModel.title
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindViewModel() {
        reservViewModel.getReservation()
        reservViewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
        reservViewModel.cellDataSource.bind { [weak self] reserv in
            guard let self, let reserv else { return }
            self.reserv = reserv
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func layout() {
        [tableView].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ReservationViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
}

extension ReservationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return users.count
        case 4:
            return 1
        case 5:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationInfoViewCell", for: indexPath) as! ReservationInfoViewCell
            if let reserv = reserv {
                cell.setupCell(reserv: reserv, title: titleForCell ?? "")
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationInfoReservTableViewCell", for: indexPath) as! ReservationInfoReservTableViewCell
            if let reserv = reserv {
                cell.setupCell(reserv: reserv, title: titleForCell ?? "")
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationInfoAboutBuyerViewCell", for: indexPath) as! ReservationInfoAboutBuyerViewCell
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationTouristViewCell", for: indexPath) as! ReservationTouristViewCell
            cell.selectionStyle = .none
            cell.touristLabel.text = "\(users[indexPath.row])"
            cell.delegate = self
            cell.sectionIndex = indexPath.section
            self.section = indexPath.section
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationAppendTouristViewCell", for: indexPath) as! ReservationAppendTouristViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationLastInfoViewCell", for: indexPath) as! ReservationLastInfoViewCell
            if let reserv = reserv {
                cell.setupCell(reserv: reserv)
            }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3:
            if  toogleTourist {
                return UITableView.automaticDimension
            } else {
                return 80
            }
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CustomHeaderView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 5:
            footerView.setupFooter()
            return footerView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
}

extension ReservationViewController: ReservationTouristProtocol {
    func cellHeaderCoin(idx: Int) {
        toogleTourist.toggle()
        tableView.reloadSections([idx], with: .automatic)
    }
}

extension ReservationViewController: ReservationAppendProtocol {
    func apendUser() {
        
        var user: String?
        
        switch users.count {
        case 1:
            user = "Второй турист"
        case 2:
            user = "Третий турист"
        case 3:
            user = "Четвертый турист"
        case 4:
            user = "Пятый турист"
        case 5:
            user = "Шестой турист"
        default:
            user = "Ещё турист"
        }
        users.append(user ?? "")
        guard let section else { return }
        tableView.reloadSections([section], with: .automatic)
        tableView.reloadData()
    }
}

extension ReservationViewController: ReservationFooterProtocol {
    func getPayment() {
        reservViewModel.push(.showLast)
    }
}
