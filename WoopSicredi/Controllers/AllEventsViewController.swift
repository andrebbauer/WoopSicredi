//
//  ViewController.swift
//  WoopSicredi
//
//  Created by André on 29/01/22.
//

import UIKit

class AllEventsViewController: UITableViewController {
    let cellIdentifier = "EventCell"
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
    private var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creates cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        //activity indicator
        activityIndicator.alpha = 1.0
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        APIService().fetchEvents { [weak self] (events) in
            self?.events = events
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel!.text = events[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        performSegue(withIdentifier: "EventView", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventView" {
            let controller = segue.destination as! EventViewController
            controller.event = sender as? Event
        }
    }
}
