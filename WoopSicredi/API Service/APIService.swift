import Foundation
import UIKit

class APIService {
    let apiRequestURL = Bundle.main.object(forInfoDictionaryKey: "apiRequestURL") as! String
    let apiPOSTURL = Bundle.main.object(forInfoDictionaryKey: "apiRequestURL") as! String
    
    func fetchEvents(completionHandler: @escaping ([Event]) -> Void) {
        let url = URL(string: apiRequestURL)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error accessing url: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, status code: \(String(describing: response))")
                return
            }
            let decoder2 = JSONDecoder()
            decoder2.dateDecodingStrategy = .secondsSince1970
            if let data = data,
               let events = try? decoder2.decode([Event].self, from: data) {
                completionHandler(events)
            }
        }
        task.resume()
    }
    // TODO: - Post
    func postEvent() {
        let url = URL(string: apiPOSTURL)!
        
    }
    
    func getImageFromURL(_ url: String) -> UIImage {
        var image: UIImage?

        let nsurl = NSURL(string: url)! as URL
        if let imageData: NSData = NSData(contentsOf: nsurl) {
            image = UIImage(data: imageData as Data)
            return image!
        }
        return UIImage(systemName: "heart.fill")!
    }
}
