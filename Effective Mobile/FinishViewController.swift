//
//  FinishViewController.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 12.01.2024.
//

import UIKit

class FinishViewController: UIViewController {

    let finishViewModel: FinishViewModel
    
    var background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.906806767, green: 0.9462431073, blue: 0.9970073104, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 90/2
        return view
    }()
    
    var image: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "party.popper@10x")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var succesPaymentLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = "Ваш заказ принят в работу"
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Подтверждение заказа №\(Int.random(in: 0..<5000)) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придёт уведомление"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        label.text = "Супер!"
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if let previousViewController = navigationController?.viewControllers.dropLast().last {
            previousViewController.title = ""
        }
        layout()
    }
    
    init(finishViewModel: FinishViewModel) {
        self.finishViewModel = finishViewModel
        super.init(nibName: nil, bundle: nil)
        
        self.title = finishViewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapButton() {
        finishViewModel.push(.start)
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first {
//            let viewModel = HotelViewModel(title: "Отель")
//            window.rootViewController = UINavigationController(rootViewController: HotelViewController(hotelViewModel: viewModel))
//            window.makeKeyAndVisible()
//        }
    }
    
    func layout() {
        [descriptionLabel,succesPaymentLabel,background,image,footerButton,titleForButton].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            succesPaymentLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor,constant: -10),
            succesPaymentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            image.bottomAnchor.constraint(equalTo: succesPaymentLabel.topAnchor,constant: -40),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            
            background.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            background.widthAnchor.constraint(equalToConstant: 90),
            background.heightAnchor.constraint(equalToConstant: 90),
            
            footerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20),
            footerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            footerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            footerButton.heightAnchor.constraint(equalToConstant: 45),
            
            titleForButton.centerYAnchor.constraint(equalTo: footerButton.centerYAnchor),
            titleForButton.centerXAnchor.constraint(equalTo: footerButton.centerXAnchor)
        ])
    }
}
