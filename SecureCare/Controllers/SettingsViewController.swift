import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Logout",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemRed
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveChangesButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Save Changes",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var showPasswordButtonCurrent: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(togglePasswordVisibilityForCurrent), for: .touchUpInside)
        return button
    }()
    
    private lazy var showPasswordButtonNew: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(togglePasswordVisibilityForNew), for: .touchUpInside)
        return button
    }()
    
    private let changeEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Change Email"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let changeEmailTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = "fakexcreator@gmail.com"
        textfield.setLeftPaddingPoints(10)
        textfield.backgroundColor = .systemGray2
        return textfield
    }()
    
    private let changePasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Change Password"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var currentPasswordTextField: UITextField = {
        let textfield = UITextField()
        textfield.isSecureTextEntry = true
        textfield.placeholder = "Enter your current password"
        textfield.setLeftPaddingPoints(10)
        textfield.backgroundColor = .systemGray2
        textfield.rightView = showPasswordButtonCurrent
        textfield.rightViewMode = .always
        return textfield
    }()
    
    private lazy var changePasswordTextField: UITextField = {
        let textfield = UITextField()
        textfield.isSecureTextEntry = true
        textfield.placeholder = "Entere your new password"
        textfield.setLeftPaddingPoints(10)
        textfield.backgroundColor = .systemGray2
        textfield.rightView = showPasswordButtonNew
        textfield.rightViewMode = .always
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        changeEmailTextField.layer.masksToBounds = true
        changeEmailTextField.layer.cornerRadius = 14
        changePasswordTextField.layer.masksToBounds = true
        changePasswordTextField.layer.cornerRadius = 14
        currentPasswordTextField.layer.masksToBounds = true
        currentPasswordTextField.layer.cornerRadius = 14
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(logoutButton)
        view.addSubview(changeEmailLabel)
        view.addSubview(changeEmailTextField)
        view.addSubview(changePasswordLabel)
        view.addSubview(currentPasswordTextField)
        view.addSubview(changePasswordTextField)
        view.addSubview(saveChangesButton)
    }
    
    private func configureConstraints() {
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        changeEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(25)
        }
        
        changeEmailTextField.snp.makeConstraints { make in
            make.top.equalTo(changeEmailLabel.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        changePasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(changeEmailTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(25)
        }
        
        currentPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(changePasswordLabel.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        changePasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(15)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.top.equalTo(changePasswordTextField.snp.bottom).offset(40)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func logoutButtonTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error when signing out")
        }
    }
    
    
    @objc private func togglePasswordVisibilityForCurrent() {
        currentPasswordTextField.isSecureTextEntry.toggle()
        let buttonImageName = currentPasswordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        showPasswordButtonCurrent.setImage(UIImage(systemName: buttonImageName), for: .normal)
    }
    
    @objc private func togglePasswordVisibilityForNew() {
        changePasswordTextField.isSecureTextEntry.toggle()
        let buttonImageName = changePasswordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
        showPasswordButtonNew.setImage(UIImage(systemName: buttonImageName), for: .normal)
    }
}

