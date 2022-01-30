import Foundation

class EventViewModel {
    let apiURL = Bundle.main.object(forInfoDictionaryKey: "apiURL") as! String
    
    func fetchEvents(completionHandler: @escaping ([Event]) -> Void) {
        let url = URL(string: apiURL)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error accessing url: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, status code: \(response)")
                return
            }
            if let data = data,
               let events = try? JSONDecoder().decode([Event].self, from: data) {
                // print("Id: \(event.id)\nPrice: \(event.price)\nDate: \(event.date)\n Description: \(event.description)\nCoordinates: \(event.latitude)lat \(event.longitude)long")
                completionHandler(events)
            }
        }
        task.resume()
    }
}
