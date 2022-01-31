import UIKit

struct Event: Decodable {
    var people: [String]
    var date: Double
    var description: String
    var image: String
    var longitude: Double
    var latitude: Double
    var price: Float
    var title: String
    var id: String
}
