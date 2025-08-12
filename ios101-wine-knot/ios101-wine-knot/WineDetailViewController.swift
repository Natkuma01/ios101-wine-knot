import UIKit

import NukeExtensions

class WineDetailViewController: UIViewController {
    
    var wine: Wine?

    // MARK: - Outlets
    @IBOutlet weak var wineNameLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var countryRegionLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var grapesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        performSegue(withIdentifier: "ShowInventorySegue", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowInventorySegue" {
            if let inventoryVC = segue.destination as? InventoryViewController, let wine = wine {
                //inventoryVC.wine = wine
            }
        }
    }
}
