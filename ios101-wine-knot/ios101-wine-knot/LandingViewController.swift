import UIKit

class LandingViewController: UIViewController {
    
    // No need for a custom UIImageView IBOutlet if you're not interacting with it directly.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Removed the DispatchQueue.main.asyncAfter timer code.
    }
    
    // This function will be triggered by tapping the "Start" button.
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let restaurantListVC = storyboard.instantiateViewController(withIdentifier: "RestaurantListViewController") as? RestaurantListViewController {
            navigationController?.pushViewController(restaurantListVC, animated: true)
        }
    }
}
