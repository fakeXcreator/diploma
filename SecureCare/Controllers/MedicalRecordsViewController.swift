import UIKit

class MedicalRecordsViewController: UIViewController {
    
    var records = Records.getRecords()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

extension MedicalRecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { fatalError() }
        let record = records[indexPath.row]
        cell.setupCell(recordText: record.record, dateText: record.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let record = records[indexPath.row]
        let vc = MedicalRecordDetailViewController(record: record.record, date: record.date, description: record.description)
        navigationController?.pushViewController(vc, animated: true)
    }
}

