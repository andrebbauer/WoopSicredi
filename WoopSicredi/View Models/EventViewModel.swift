import Foundation
import UIKit

class EventViewModel {
    private var events = [Event]()
    
    func convertDate(_ date: Double) -> String {
        let timestamp = Date(timeIntervalSince1970: date/1000)
        return DateFormatter.localizedString(from: timestamp, dateStyle: .medium, timeStyle: .short)
    }
    
    func formatPrice(_ price: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: price as NSNumber)!
    }
}
