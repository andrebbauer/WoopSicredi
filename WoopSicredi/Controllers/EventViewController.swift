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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event {
            title = event.title
            dateLabel.text = eventViewModel.convertDate(date: event.date)
            descriptionLabel.text = event.description
            imageView.image = eventViewModel.getImageFromURL(event.image)
            longitudeLabel.text = String(event.longitude)
            latitudeLabel.text = String(event.latitude)
            priceLabel.text = eventViewModel.formatPrice(event.price)
        }
    }
    
    @IBAction func didTapCheckInButton() {
        performSegue(withIdentifier: "CheckIn", sender: event?.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckIn" {
            let controller = segue.destination as! CheckInViewController
            controller.eventId = sender as? String
        }
    }
}
