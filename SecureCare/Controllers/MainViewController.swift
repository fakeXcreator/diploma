import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.configuration?.baseForegroundColor = .white
        button.configuration?.image = UIImage(systemName: "gear")
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var medicalRecordsButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Medical Records",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(medicalRecordsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var makeAppointmentButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Make an Appointment",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(makeAppointmentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var myAppointmentsButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "My Appointments",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(myAppointmentsButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(imageView)
        view.addSubview(settingsButton)
        view.addSubview(medicalRecordsButton)
        view.addSubview(makeAppointmentButton)
        view.addSubview(myAppointmentsButton)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        medicalRecordsButton.snp.makeConstraints { make in
            make.top.equalTo(myAppointmentsButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        makeAppointmentButton.snp.makeConstraints { make in
            make.bottom.equalTo(myAppointmentsButton.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        myAppointmentsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
    
    private func validateAuth() {
        if  FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
    private func validateAuthForRegistration() {
            if FirebaseAuth.Auth.auth().currentUser == nil {
                let vc = RegisterViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        }
    
    @objc private func settingsButtonTapped() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func medicalRecordsButtonTapped() {
        let vc = MedicalRecordsViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc private func makeAppointmentButtonTapped() {
        let vc = MakeAppointmentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func myAppointmentsButtonTapped() {
        let vc = MyAppointmentsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
