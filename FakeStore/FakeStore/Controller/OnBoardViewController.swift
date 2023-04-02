//
//  OnboardViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/04/01.
//

import UIKit

class OnBoardViewController: UIViewController {
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .colorWithHex(hex: 0xD2D2D2)
        button.tintColor = .blue
        button.layer.cornerRadius = 12
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    
}
