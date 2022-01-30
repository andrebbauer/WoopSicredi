//
//  ViewController.swift
//  WoopSicredi
//
//  Created by André on 29/01/22.
//

import UIKit

class EventViewController: UITableViewController {
    let cellIdentifier = "EventCell"
    
    private var events = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        EventViewModel().fetchEvents { [weak self] (events) in
            self?.events = events
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel!.text = events[indexPath.row].id
        
        return cell
    }
}

