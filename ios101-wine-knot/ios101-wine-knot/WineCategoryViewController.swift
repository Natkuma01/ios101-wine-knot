import UIKit

class WineCategoryViewController: UIViewController {
    
    @IBOutlet weak var redWineImageView: UIImageView!
    @IBOutlet weak var whiteWineImageView: UIImageView!
    @IBOutlet weak var sparklingWineImageView: UIImageView!
    @IBOutlet weak var orangeWineImageView: UIImageView!
    
    var selectedRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redWineImageView.image = UIImage(named: "red_wine")
        whiteWineImageView.image = UIImage(named: "white_wine")
        sparklingWineImageView.image = UIImage(named: "sparkling_wine")
        orangeWineImageView.image = UIImage(named: "orange_wine")
        
        // Enable taps
        setupTapGestures()
    }
        
    private func setupTapGestures() {
        let categories: [(UIImageView, String)] = [
            (redWineImageView, "red"),
            (whiteWineImageView, "white"),
            (sparklingWineImageView, "sparkling"),
            (orangeWineImageView, "orange")
        ]
        
        for (imageView, category) in categories {
            imageView.isUserInteractionEnabled = true
            imageView.accessibilityLabel = category
            let tap = UITapGestureRecognizer(target: self, action: #selector(categoryTapped(_:)))
            imageView.addGestureRecognizer(tap)
        }
    }
        
    @objc private func categoryTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView,
              let category = tappedImageView.accessibilityLabel else { return }
        
        print("Category tapped:", category) // ✅ Debug
        
        // Navigate to WineListViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let wineListVC = storyboard.instantiateViewController(withIdentifier: "WineListViewController") as? WineListViewController {
            wineListVC.selectedRestaurant = selectedRestaurant
            wineListVC.selectedCategory = category
            navigationController?.pushViewController(wineListVC, animated: true)
        }
    }
}
