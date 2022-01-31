//
//  EventViewModel.swift
//  WoopSicredi
//
//  Created by André on 31/01/22.
//

import Foundation

class EventViewModel {
    private var apiService: APIService!
    private var events = [Event]()
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchEvents() -> [Event] {
        self.apiService.fetchEvents { [weak self] events in
            self?.events = events
        }
        return self.events
    }
    
    func convertDate(date: Double) -> String {
        let timestamp = Date(timeIntervalSince1970: date/1000)
        return DateFormatter.localizedString(from: timestamp, dateStyle: .medium, timeStyle: .short)
    }
}
