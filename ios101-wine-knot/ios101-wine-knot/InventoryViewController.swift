import UIKit

class InventoryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var donutImageView: UIImageView!
    @IBOutlet weak var numberOfBottlesLabel: UILabel!
    @IBOutlet weak var buyingPriceLabel: UILabel!
    @IBOutlet weak var sellingPriceLabel: UILabel!
    @IBOutlet weak var sellingPriceTextField: UITextField!
    @IBOutlet weak var marginLabel: UILabel!
    @IBOutlet weak var marginPercentageLabel: UILabel!

    // store these data locally - userDefault
    private var buyingPrice: Double = 0.0
    private var sellingPrice: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        donutImageView.image = UIImage(named: "donut")
        setupUI()
        setupTextFields()
    }
    
    private func setupUI() {
        
        let numberOfBottles = Int.random(in: 0...500)
        numberOfBottlesLabel.text = "In Stock: \(numberOfBottles) Bottles"
        
        // load existing prices / generate new ones
        loadPrices()
        
        let formatedBuyingPrice = String(format: "%.2f", buyingPrice)
        buyingPriceLabel.text = "Buying Price: $\(formatedBuyingPrice)"
        
        sellingPriceTextField.text = String(format: "%.2f", sellingPrice)
        
        sellingPriceLabel.text = "Selling Price: $"
        
        calculateValues()
    }
    
    private func setupTextFields() {
        // only need to listen for changes on the selling price text field
        sellingPriceTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sellingPriceDidChange()
        return true
    }

    @objc private func sellingPriceDidChange() {
        
        if let text = sellingPriceTextField.text, let price = Double(text) {
            sellingPrice = price
            savePrices() // save new selling price
        } else {
            // Handle invalid input
            sellingPriceTextField.text = String(format: "%.2f", buyingPrice)
            sellingPrice = buyingPrice
        }
        
        calculateValues()
    }
    
    private func generateNewPrices() {
        buyingPrice = Double.random(in: 30.0...1000.0)
        sellingPrice = Double.random(in: buyingPrice...1500.0)
        savePrices()
    }
    
    private func savePrices() {
        let defaults = UserDefaults.standard
        defaults.set(buyingPrice, forKey: "inventoryBuyingPrice")
        defaults.set(sellingPrice, forKey: "inventorySellingPrice")
    }
    
    private func loadPrices() {
        let defaults = UserDefaults.standard
        let savedBuyingPrice = defaults.double(forKey: "inventoryBuyingPrice")
        let savedSellingPrice = defaults.double(forKey: "inventorySellingPrice")
        
        // if no saved price, generate a new price
        if savedBuyingPrice > 0 {
            buyingPrice = savedBuyingPrice
            sellingPrice = savedSellingPrice
        } else {
            generateNewPrices()
        }
    }
    
    private func calculateValues() {
        let margin = sellingPrice - buyingPrice
        let formatedMarginPrice = String(format: "%.2f", margin)
        marginLabel.text = "Margin Price: $\(formatedMarginPrice)"
        
        if buyingPrice > 0 {
            let marginPercentage = (margin / buyingPrice) * 100
            let formatedMarginPercentage: String = String(format: "%.2f", marginPercentage)
            marginPercentageLabel.text = "Margin percentage: \(formatedMarginPercentage)%"
        } else {
            marginPercentageLabel.text = "0.00%"
        }
    }
}
