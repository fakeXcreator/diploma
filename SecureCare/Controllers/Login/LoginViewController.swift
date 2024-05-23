import UIKit
import FirebaseAuth
import SnapKit

class LoginViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.textColor = .black
        textField.keyboardType = .emailAddress
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.returnKeyType = .done
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(40)
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Login",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        let text = "Don't have an account? Sign Up"
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "Sign Up")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        label.attributedText = attributedString
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        configureUI()
        addTapGestureToRegisterLabel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(imageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerLabel)
    }
    
    private func configureUI() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }

        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        registerLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addTapGestureToRegisterLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerLabelTapped))
        registerLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let buttonImageName = passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        showPasswordButton.setImage(UIImage(systemName: buttonImageName), for: .normal)
    }
    
    @objc private func loginButtonTapped() {
        guard let email = loginTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty else {
            presentAlert(title: "Error", message: "Email and password fields cannot be empty.")
            return
        }
        
        if password.count < 6 {
            presentAlert(title: "Invalid Password", message: "Your password should contain more than 6 characters")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let result = authResult, error == nil else {
                self?.presentAlert(title: "Wrong Credentials", message: "Your Email or Password is wrong. Please check them again")
                return
            }
           
            let user = result.user
            print("Logged in User: \(user)")
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func registerLabelTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
        registerVC.modalPresentationStyle = .pageSheet
        present(registerVC, animated: true, completion: nil)
    }
    
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
