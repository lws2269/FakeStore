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
        label.font = .boldSystemFont(ofSize: 14)
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
        label.font = .boldSystemFont(ofSize: 14)
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
        textField.isSecureTextEntry = true
        textField.backgroundColor = .colorWithHex(hex: 0xEEEFF1)
        return textField
    }()
    
    private let passwordHideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .colorWithHex(hex: 0x696B72)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        return button
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
    
    private let signUpAndResetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입 하러가기"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .colorWithHex(hex: 0x696B72)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorWithHex(hex: 0x878787)
        return view
    }()
    
    private let passwordResetLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 재설정"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .colorWithHex(hex: 0x696B72)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        nameTextField.delegate = self
        passwordTextField.delegate = self
        setUI()
        setConstraints()
        setActionAndGesture()
    }
    
    private func isInputVaild(_ input: String?) -> Bool {
        if let input {
            return input.count > 0 ? true : false
        }
        return false
    }
}

// MARK: - Action
extension LoginViewController {
    @objc private func passwordHideButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        passwordHideButton.isSelected.toggle()
        
        let buttonImage = UIImage(systemName:
                                    passwordTextField.isSecureTextEntry ? "eye" : "eye.slash")
        passwordHideButton.setImage(buttonImage, for: .normal)
    }
    
    @objc private func loginButtonTapped() {
        let listViewController = ListViewController()
        self.navigationController?.pushViewController(listViewController, animated: true)
    }
    
    @objc func signUpLabelTapped() {
        print("회원가입 버튼 클릭")
    }
    
    @objc func passwordResetLabelTapped() {
        print("리셋 버튼 클릭")
    }
}

// MARK: - TextFieldDelegate
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

// MARK: - Coniguration Method
extension LoginViewController {
    private func setUI() {
        [signUpLabel, lineView, passwordResetLabel].forEach {
            signUpAndResetStackView.addArrangedSubview($0)
        }
        
        [pageLabel, nameLabel, nameTextField, passwordLabel, passwordTextField, passwordHideButton, loginButton, signUpAndResetStackView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setActionAndGesture() {
        let signUpGesture = UITapGestureRecognizer(target: self, action: #selector(signUpLabelTapped))
        let resetGesture = UITapGestureRecognizer(target: self, action: #selector(passwordResetLabelTapped))
        signUpLabel.addGestureRecognizer(signUpGesture)
        passwordResetLabel.addGestureRecognizer(resetGesture)
        
        passwordHideButton.addTarget(self, action: #selector(passwordHideButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.isEnabled = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 114),
            pageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 34),
            nameLabel.leadingAnchor.constraint(equalTo: pageLabel.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            
            passwordLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 11),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordHideButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordHideButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),
            
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 76),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            lineView.heightAnchor.constraint(equalToConstant: 14),
            lineView.widthAnchor.constraint(equalToConstant: 1),
            
            signUpAndResetStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 34),
            signUpAndResetStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
