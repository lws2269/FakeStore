//
//  ViewController.swift
//  FakeStore
//
//  Created by leewonseok on 2023/03/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorWithHex(hex: 0x696B72)
        label.text = "로그인"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorWithHex(hex: 0x696B72)
        label.text = "Username"
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Username을 입력해 주세요."
        textField.backgroundColor = .colorWithHex(hex: 0xEEEFF1)
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .colorWithHex(hex: 0x696B72)
        label.text = "Password"
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password을 입력해 주세요."
        textField.backgroundColor = .colorWithHex(hex: 0xEEEFF1)
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .colorWithHex(hex: 0xD2D2D2)
        button.layer.cornerRadius = 12
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setPageLabel()
        setNameLabelAndField()
        setPasswordLabelAndField()
        setLoginButton()
        nameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setPageLabel() {
        view.addSubview(pageLabel)
        
        NSLayoutConstraint.activate([
            pageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 114),
            pageLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16)
        ])
    }
    
    private func setNameLabelAndField() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 34),
            nameLabel.leftAnchor.constraint(equalTo: pageLabel.leftAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            nameTextField.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            nameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func setPasswordLabelAndField() {
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            passwordLabel.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 11),
            passwordTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: nameTextField.rightAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func setLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.isEnabled = false
        
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 116),
            loginButton.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            loginButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor),

            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func isInputVaild(_ input: String?) -> Bool {
        if let input {
            return input.count > 0 ? true : false
        }
        return false
    }
    
    @objc private func loginButtonTapped() {
        print("다음 화면으로")
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isInputVaild(nameTextField.text) {
            loginButton.backgroundColor = .colorWithHex(hex: 0x2358E1)
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .colorWithHex(hex: 0xD2D2D2)
            loginButton.isEnabled = false
        }
    }
}
