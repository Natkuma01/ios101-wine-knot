import UIKit

class LandingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getStartedTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let restaurantListVC = storyboard.instantiateViewController(withIdentifier: "RestaurantListViewController") as? RestaurantListViewController {
            navigationController?.pushViewController(restaurantListVC, animated: true)
        }
    }
}
