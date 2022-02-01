import Foundation
class CheckInViewModel {
    
    func validateTextFields(_ name: String, _ email: String) -> Bool{
        if (!name.isEmpty || !email.isEmpty) &&
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email) {
            
            return true
        }
        return false
    }
}
