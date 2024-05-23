import UIKit

class AppointmentDetailViewController: UIViewController {
    
    private let doctorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    init(doctor: String, date: String, time: String) {
        doctorLabel.text = doctor
        dateLabel.text = date
        timeLabel.text = time
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(doctorLabel)
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
    }
    
    private func configureConstraints() {
        doctorLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(70)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(doctorLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(20)
        }
    }
}
