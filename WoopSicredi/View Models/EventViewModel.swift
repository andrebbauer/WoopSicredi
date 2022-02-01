import Foundation
import UIKit

class EventViewModel {
    private var apiService: APIService!
    private var events = [Event]()
    
    init() {
        self.apiService = APIService.shared
    }
    
    func fetchEvents() -> [Event] {
        self.apiService.fetchEvents { [weak self] events in
            self?.events = events
        }
        return self.events
    }
    
    func convertDate(_ date: Double) -> String {
        let timestamp = Date(timeIntervalSince1970: date/1000)
        return DateFormatter.localizedString(from: timestamp, dateStyle: .medium, timeStyle: .short)
    }
    
    func getImageFromURL(_ url: String) -> UIImage {
        return apiService.getImageFromURL(url)
    }
    
    func formatPrice(_ price: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: price as NSNumber)!
    }
}
