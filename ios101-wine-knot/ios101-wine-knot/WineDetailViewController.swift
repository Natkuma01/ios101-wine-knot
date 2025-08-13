import UIKit

import NukeExtensions

class WineDetailViewController: UIViewController {
    
    var wine: Wine?

    
    @IBOutlet weak var wineNameLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var countryRegionLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var grapesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the wine image view
        wineImageView.layer.cornerRadius = 10
        wineImageView.clipsToBounds = true
        
        // Load wine data
        loadWineData()
    }
    
    // MARK: - Helper Methods
    
    private func loadWineData() {
        updateUI()
    }
    
    
    func updateUI() {
        
        guard let wine = wine else { return }

        wineNameLabel.text = wine.name
        producerLabel.text = "Producer: \(wine.producer)"
        countryRegionLabel.text = "Region: \(wine.country), \(wine.region)"
        notesTextView.text = wine.notes
        yearLabel.text = "Year: \(wine.year ?? 0)"
        grapesLabel.text = "Grapes: \(wine.grapes.joined(separator: ", "))"

        if let imageURL = URL(string: wine.imageURL) {
            NukeExtensions.loadImage(with: imageURL, into: wineImageView)
        } else {
            wineImageView.image = UIImage(named: "dplaceholder-wine-image")
        }
    }
    

    @IBAction func inventoryTrackingButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let inventoryVC = storyboard.instantiateViewController(withIdentifier: "InventoryViewController") as? InventoryViewController {
            navigationController?.pushViewController(inventoryVC, animated: true)
        }
    }
    
    
}
