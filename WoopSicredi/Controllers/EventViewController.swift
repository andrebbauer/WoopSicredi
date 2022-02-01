//
//  EventTableViewController.swift
//  WoopSicredi
//
//  Created by André on 30/01/22.
//

import UIKit

class EventViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var event: Event?
    let eventViewModel = EventViewModel()
    let apiService = APIService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEventValuesToFields()
    }
    
    @IBAction func didTapCheckInButton() {
        performSegue(withIdentifier: "CheckIn", sender: event?.id)
    }
    
    @IBAction func didTapShareButton() {
        let text = """
                   Hey, come meet me at this event!!
                   \(event!.title)
                   It starts at: \(eventViewModel.convertDate(event!.date))
                   Location: \(event!.longitude), \(event!.latitude)
                   """
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        activityViewController.isModalInPresentation = true
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckIn" {
            let controller = segue.destination as! CheckInViewController
            controller.eventId = sender as? String
        }
    }
    
    func setEventValuesToFields() {
        if let event = event {
            title = event.title
            dateLabel.text = eventViewModel.convertDate(event.date)
            descriptionLabel.text = event.description
            imageView.image = apiService.getImageFromURL(event.image)
            longitudeLabel.text = String(event.longitude)
            latitudeLabel.text = String(event.latitude)
            priceLabel.text = eventViewModel.formatPrice(event.price)
        }
    }
}
