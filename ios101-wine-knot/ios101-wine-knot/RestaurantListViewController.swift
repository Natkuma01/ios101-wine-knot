import UIKit

class RestaurantListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var restaurants: [Restaurant] = []
    private let restaurantsKey = "savedRestaurants"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadRestaurants()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRestaurants()
        tableView.reloadData()
    }

    private func setupUI() {
        title = "Restaurants"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRestaurantTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc private func addRestaurantTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addVC = storyboard.instantiateViewController(withIdentifier: "AddRestaurantViewController") as? AddRestaurantViewController {
            addVC.delegate = self
            let nav = UINavigationController(rootViewController: addVC)
            present(nav, animated: true)
        }
    }

    private func loadRestaurants() {
        if let data = UserDefaults.standard.data(forKey: restaurantsKey),
           let saved = try? JSONDecoder().decode([Restaurant].self, from: data) {
            restaurants = saved
        }
    }

    private func saveRestaurants() {
        if let data = try? JSONEncoder().encode(restaurants) {
            UserDefaults.standard.set(data, forKey: restaurantsKey)
        }
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
        content.secondaryText = restaurant.address
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurants.remove(at: indexPath.row)
            saveRestaurants()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }}

extension RestaurantListViewController: AddRestaurantDelegate {
    func didAddRestaurant(_ restaurant: Restaurant) {
        restaurants.append(restaurant)
        saveRestaurants()
        tableView.reloadData()
    }
}
