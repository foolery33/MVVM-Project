//
//  LoginScreenView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import UIKit
import SnapKit

class LoginScreenView: UIView {

    var viewModel: LoginViewModel
    
    private enum Paddings {
        static let betweenTopAndLogo = 132.0
        static let defaultPadding = 16.0
        static let betweenLogoAndEmail = 104.0
        static let betweenPasswordAndLogin = 156.0
        static let betweenBottomAndRegister = 44.0
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        setupSubviews()
        addKeyboardDidmiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Global setup
    
    private func setupSubviews() {
        setupLogo()
        setupTextFieldsStackView()
        setupButtonsStackView()
    }
    
    // MARK: Keyboard dismiss
    
    func addKeyboardDidmiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    // MARK: Logotype setup
    
    private lazy var logotype: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "LogoWithName")!
        return logo
    }()
    private func setupLogo() {
        addSubview(logotype)
        logotype.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.top).offset(Paddings.betweenTopAndLogo)
            make.centerX.equalTo(self)
            
        }
    }
    
    // MARK: TextField's StackView setup
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Paddings.defaultPadding
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        return stackView
    }()
    private func setupTextFieldsStackView() {
        addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logotype.snp.bottom).offset(Paddings.betweenLogoAndEmail)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    
    // MARK: Email setup
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()

        textField.text = viewModel.email
        textField.autocapitalizationType = .none
        textField.textColor = UIColor.red
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        textField.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        textField.addTarget(self, action: #selector(updateEmail(_:)), for: .editingChanged)
        
        return textField
    }()
    @objc
    private func updateEmail(_ textField: UITextField) {
        self.viewModel.email = textField.text ?? ""
    }
    
    // MARK: Password setup
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()

        textField.text = viewModel.password
        textField.autocapitalizationType = .none
        textField.textColor = UIColor.red
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true

        textField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.rightView = passwordEye
        textField.rightViewMode = .always
        
        textField.addTarget(self, action: #selector(updatePassword(_:)), for: .editingChanged)
        
        return textField
    }()
    private lazy var passwordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eye.setImage(UIImage(systemName: "eye"), for: .selected)
        eye.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return eye
    }()
    @objc
    func togglePasswordVisibility(_ sender: UIButton) {
        viewModel.isPasswordHidden.toggle()
        passwordTextField.isSecureTextEntry = viewModel.isPasswordHidden
        sender.isSelected = !sender.isSelected
    }
    @objc
    private func updatePassword(_ textField: UITextField) {
        self.viewModel.password = textField.text ?? ""
    }
    
    // MARK: Button's StackView setup
    
    private lazy var buttonsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = Paddings.defaultPadding
        myStackView.addArrangedSubview(loginButton)
        myStackView.addArrangedSubview(registerButton)
        return myStackView
    }()
    private func setupButtonsStackView() {
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-Paddings.betweenBottomAndRegister)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    
    // MARK: Login setup
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.backgroundColor = UIColor.red.cgColor
        button.setTitle("Войти", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        return button
    }()
    @objc
    private func goToMainScreen() {
        let passResult = GoToMainScreenPassResultUseCase().getResult(email: viewModel.email, password: viewModel.password)
        showAlertController(title: passResult.0, message: passResult.1)
    }
    
    // MARK: Register setup
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.backgroundColor = UIColor.red.cgColor
        button.setTitle("Регистрация", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(goToRegisterScreen), for: .touchUpInside)
        return button
    }()
    @objc
    private func goToRegisterScreen() {
        showAlertController(title: "Success", message: "You've moved to the Register Screen")
    }
    
    func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        if let viewController = self.next as? UIViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
