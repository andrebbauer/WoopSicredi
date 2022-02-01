import UIKit

class AllEventsViewController: UITableViewController {
    let cellIdentifier = "EventCell"
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
    
    private var events = [Event]()
    let allEventsViewModel = AllEventsViewModel()
    let apiService = APIService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // creates cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        setActivityIndicator()
        fetchEvents()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.imageView!.image = UIImage(systemName: "book.circle.fill")
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
    
    func setActivityIndicator() {
        activityIndicator.alpha = 1.0
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func fetchEvents() {
        apiService.fetchEvents { [weak self] (events) in
            self?.events = events
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
}
