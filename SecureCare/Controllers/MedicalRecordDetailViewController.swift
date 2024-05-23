import UIKit

class MedicalRecordDetailViewController: UIViewController {
    
    private let titleLabel: UILabel = {
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
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.showsHorizontalScrollIndicator = false
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textColor = .white
        textView.isUserInteractionEnabled = false
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        return textView
    }()
    
    init(record: String, date: String, description: String) {
        titleLabel.text = record
        dateLabel.text = date
        descriptionTextView.text = description
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
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(dateLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(70)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.bottom.equalTo(dateLabel.snp.top).offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
