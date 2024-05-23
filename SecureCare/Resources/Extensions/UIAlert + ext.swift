import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
