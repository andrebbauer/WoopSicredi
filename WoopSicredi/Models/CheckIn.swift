class CheckIn: Codable {
    let eventId: String
    let name: String
    let email: String
    
    init(_ eventId: String, _ name: String, _ email: String) {
        self.eventId = eventId
        self.name = name
        self.email = email
    }
}
