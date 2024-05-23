import UIKit

class MyAppointmentsViewController: UIViewController {
    
    var appointments = Appointments.currentAppointments
    
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

extension MyAppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { fatalError() }
        let appointment = appointments[indexPath.row]
        cell.setupCell(recordText: appointment.doctor, dateText: appointment.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let appointment = appointments[indexPath.row]
        // Замените MedicalRecordDetailViewController на соответствующий контроллер для деталей записи о встрече
        let vc = AppointmentDetailViewController(doctor: appointment.doctor, date: appointment.date, time: appointment.time)
        navigationController?.pushViewController(vc, animated: true)
    }
}
