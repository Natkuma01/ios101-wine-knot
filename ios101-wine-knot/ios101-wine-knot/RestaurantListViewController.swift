import UIKit

class RestaurantListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var restaurants: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchRestaurants()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRestaurants()
    }

    private func setupUI() {
        title = "Restaurants"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRestaurantTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RestaurantCell") // Make sure cell is registered
    }

    @objc private func addRestaurantTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addVC = storyboard.instantiateViewController(withIdentifier: "AddRestaurantViewController") as? AddRestaurantViewController {
            addVC.delegate = self
            let nav = UINavigationController(rootViewController: addVC)
            present(nav, animated: true)
        }
    }
    
    private func fetchRestaurants() {
        guard let url = URL(string: "http://127.0.0.1:8000/restaurants/restaurants/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching restaurants:", error)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let fetchedRestaurants = try JSONDecoder().decode([Restaurant].self, from: data)
                self.restaurants = fetchedRestaurants
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Decoding error:", error)
            }
        }
        
        task.resume()
    }
}

extension RestaurantListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)
        let restaurant = restaurants[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = restaurant.name
        cell.contentConfiguration = content
        return cell
    }
    
    // Delete restaurant locally (consider API delete later)
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let wineListVC = storyboard.instantiateViewController(withIdentifier: "WineListViewController") as? WineListViewController {
            let selectedRestaurant = restaurants[indexPath.row]
            wineListVC.selectedRestaurant = selectedRestaurant
            navigationController?.pushViewController(wineListVC, animated: true)
        }
    }
}

extension RestaurantListViewController: AddRestaurantDelegate {
    func didAddRestaurant(_ restaurant: Restaurant) {
        fetchRestaurants()
    }
}
