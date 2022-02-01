import Foundation
import UIKit

class CheckInViewController: UIViewController {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var eventId: String?
    let checkInViewModel = CheckInViewModel()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
        
        // ui small details
        doneBarButton.isEnabled = false
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        nameTextField.layer.cornerRadius = 8.0
        self.nameTextField.delegate = self
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.secondaryLabel.cgColor
        emailTextField.layer.cornerRadius = 8.0
        self.emailTextField.delegate = self
        //activity indicator
        activityIndicator.alpha = 1.0
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
    }
    
    @IBAction func didTapDone(){
        if !emailTextField.text!.isEmpty && !nameTextField.text!.isEmpty {
            if let eventId = eventId {
                activityIndicator.startAnimating()
                let checkIn = CheckIn(eventId, nameTextField.text!, emailTextField.text!)
                checkInViewModel.postCheckIn(with: checkIn)
                activityIndicator.stopAnimating()
                
                let alert = UIAlertController(title: "Great", message: "You just checked in!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension CheckInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == self.emailTextField {
            didTapDone()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text else {
            return false
        }
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        if (textField == nameTextField && !newText.isEmpty && !emailTextField.text!.isEmpty) || (textField == emailTextField && !newText.isEmpty && !nameTextField.text!.isEmpty) {
            doneBarButton.isEnabled = !newText.isEmpty
        }
        
        return true
    }
    
}
