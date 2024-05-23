import UIKit
import FirebaseAuth
import SnapKit

class ConfirmViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Confirmation Code",
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
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Confirm",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(imageView)
        view.addSubview(codeTextField)
        view.addSubview(confirmButton)
    }
    
    private func configureUI() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc private func confirmButtonTapped() {
        guard let enteredCode = codeTextField.text, !enteredCode.isEmpty else {
            presentAlert(title: "Error", message: "Please enter the confirmation code.")
            return
        }
        
        // This is a placeholder for the actual confirmation code verification
        let confirmationCode = "123456" // Assume we get this from a text field
        
        if enteredCode == confirmationCode {
            let mainVC = MainViewController()
            if let navigationController = self.navigationController {
                navigationController.pushViewController(mainVC, animated: true)
            } else {
                mainVC.modalPresentationStyle = .fullScreen
                present(mainVC, animated: true, completion: nil)
            }
        } else {
            presentAlert(title: "Error", message: "Invalid confirmation code.")
        }
    }
    
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
