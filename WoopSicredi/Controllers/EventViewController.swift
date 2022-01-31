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
    var eventViewModel = EventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event {
            title = event.title
            dateLabel.text = eventViewModel.convertDate(date: event.date)
            descriptionLabel.text = event.description
            imageView.image = APIService().getImageFromURL(event.image)
            longitudeLabel.text = String(event.longitude)
            latitudeLabel.text = String(event.longitude)
            priceLabel.text = String(event.price)
            
        }
        
    }
}
