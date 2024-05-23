import UIKit
import iOSDropDown

class MakeAppointmentViewController: UIViewController {
    let typeSource = ["Therapist", "ENT", "Dentist", "Endocrinologist", "Neurologist"]
    private var selectedTypeText: String?
    
    private lazy var appointButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        let attributedTitle = NSAttributedString(
            string: "Appoint",
            attributes: [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .white
        button.configuration?.buttonSize = .large
        button.addTarget(self, action: #selector(appointButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let typeView: UIView = {
        let someView = UIView()
        someView.backgroundColor = .systemGray2
        return someView
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "TYPE"
        label.textColor = .white
        return label
    }()

    private lazy var dropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.optionArray = typeSource
        dropDown.selectedRowColor = .systemGreen
        dropDown.backgroundColor = .white
        dropDown.textColor = .black
        dropDown.setLeftPaddingPoints(7)
        dropDown.font = .systemFont(ofSize: 16)
        dropDown.didSelect { [weak self] selectedText, index, id in
            self?.selectedTypeText = selectedText
        }
        dropDown.isSearchEnable = false
        
        // Настройка внутренней стрелки
        let arrowImageView = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill"))
        arrowImageView.tintColor = .black
        arrowImageView.contentMode = .scaleAspectFit

        // Настройка контейнера для стрелки
        let arrowContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        arrowImageView.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        arrowContainer.addSubview(arrowImageView)

        // Добавление стрелки в качестве subview текстового поля
        dropDown.addSubview(arrowContainer)
        
        // Позиционирование стрелки внутри текстового поля
        dropDown.rightView = arrowContainer
        dropDown.rightViewMode = .always

        // Установка отступов
        dropDown.setLeftPaddingPoints(10)
        dropDown.setRightPaddingPoints(30)

        return dropDown
    }()
    
    private let dateView: UIView = {
        let someView = UIView()
        someView.backgroundColor = .systemGray2
        return someView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "DATE"
        label.textColor = .white
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.tintColor = .systemGreen
        datePicker.minimumDate = .now
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return datePicker
    }()
    
    private let timeView: UIView = {
        let someView = UIView()
        someView.backgroundColor = .systemGray2
        return someView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "TIME"
        label.textColor = .white
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .time
        datePicker.tintColor = .systemGreen
        datePicker.preferredDatePickerStyle = .compact

        // Настройка времени выбора
        let calendar = Calendar.current
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        datePicker.date = calendar.date(from: components) ?? Date()

        // Добавление обработчика изменений
        datePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)

        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        typeView.layer.masksToBounds = true
        typeView.layer.cornerRadius = 14
        dateView.layer.masksToBounds = true
        dateView.layer.cornerRadius = 14
        timeView.layer.masksToBounds = true
        timeView.layer.cornerRadius = 14
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(appointButton)
        view.addSubview(typeView)
        typeView.addSubview(typeLabel)
        typeView.addSubview(dropDown)
        view.addSubview(dateView)
        dateView.addSubview(dateLabel)
        dateView.addSubview(datePicker)
        view.addSubview(timeView)
        timeView.addSubview(timeLabel)
        timeView.addSubview(timePicker)
    }
    
    private func configureConstraints() {
        appointButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        typeView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
        
        dropDown.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
        
        dateView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalTo(typeView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
        
        datePicker.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
        
        timeView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalTo(dateView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
        }
        
        timePicker.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func appointButtonTapped() {
        guard let typeText = selectedTypeText else {
            presentAlert(title: "Type Error", message: "You Forgot to Choose Type")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: timePicker.date)
        Appointments.currentAppointments.append(Appointments(doctor: typeText, date: dateString, time: timeString))
        
        print(Appointments.currentAppointments)
        print("Appoint set to \(typeText) at Date: \(dateString), Time: \(timeString)")
    }
    
    @objc private func dateChanged() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }

    @objc private func timeChanged(_ picker: UIDatePicker) {
        let calendar = Calendar.current
        let selectedTime = picker.date

        // Создание времени 8:00 и 17:00 для сравнения
        let minTime = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: selectedTime)!
        let maxTime = calendar.date(bySettingHour: 17, minute: 0, second: 0, of: selectedTime)!

        // Проверка, находится ли выбранное время в допустимом диапазоне
        if selectedTime < minTime {
            picker.setDate(minTime, animated: true)
        } else if selectedTime > maxTime {
            picker.setDate(maxTime, animated: true)
        }
    }
}
