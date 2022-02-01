import Foundation
import UIKit

class APIService {
    let apiRequestURL = Bundle.main.object(forInfoDictionaryKey: "apiRequestURL") as! String
    let apiPOSTURL = Bundle.main.object(forInfoDictionaryKey: "apiPOSTURL") as! String
    
    static var shared: APIService = {
        return APIService()
    }()
    
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
    
    func postCheckIn(with checkIn: CheckIn) -> Bool{
        var success = true
        let url = URL(string: apiPOSTURL)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let data = try? JSONEncoder().encode(checkIn)
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    print("Error", error ?? "Unknown error")
                    success = false
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("StatusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                success = false
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        
        return success
    }
    
    func getImageFromURL(_ url: String) -> UIImage {
        var image: UIImage?
        
        let nsurl = NSURL(string: url)! as URL
        if let imageData: NSData = NSData(contentsOf: nsurl) {
            image = UIImage(data: imageData as Data)
            return image!
        }
        return UIImage(named: "broken-1")!
    }
}
