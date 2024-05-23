import Foundation

struct Appointments {
    let doctor: String
    let date: String
    let time: String
}

extension Appointments {
    static func getAppointments() -> [Appointments] {
        return [
            Appointments(doctor: "a", date: "a", time: "a")
        ]
    }
    
    static var currentAppointments: [Appointments] = []
}
