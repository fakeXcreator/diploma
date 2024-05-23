import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "Custom TableView Cell"
    
    private let gapView: UIView = {
        let gapView = UIView()
        gapView.backgroundColor = .systemGray2
        return gapView
    }()
    
    private let recordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(recordText: String, dateText: String) {
        recordLabel.text = recordText
        dateLabel.text = dateText
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(gapView)
        gapView.addSubview(recordLabel)
        gapView.addSubview(dateLabel)
    }
    
    private func configureConstraints() {
        gapView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        recordLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(dateLabel.snp.top).offset(2)
            make.top.equalToSuperview().offset(3)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gapView.layer.masksToBounds = true
        gapView.layer.cornerRadius = 14
    }
}
