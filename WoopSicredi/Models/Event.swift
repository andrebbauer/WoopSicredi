import UIKit

struct Event: Decodable {
    var people: [String]
    var date: Int
    var description: String {
        get { return "" }
        set {}
    }
    var image: String
    var longitude: Double
    var latitude: Double
    var price: Float
    var title: String
    var id: String
    
    /* required init(people: [String], description: String, image: UIImage, longitude: Double, latitude: Double, price: Float, title: String, id: Int) {
        self.people = people
        self.image = image
        self.longitude = longitude
        self.latitude = latitude
        self.price = price
        self.title = title
        self.id = id
    }
     */
}

struct EventSummary: Decodable {
    var results: [Event]
}
