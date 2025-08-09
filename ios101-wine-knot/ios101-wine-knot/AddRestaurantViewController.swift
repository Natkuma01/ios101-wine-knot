import UIKit

protocol AddRestaurantDelegate: AnyObject {
    func didAddRestaurant(_ restaurant: Restaurant)
}

class AddRestaurantViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!

    weak var delegate: AddRestaurantDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Restaurant"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }

    @objc private func saveTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let address = addressTextField.text, !address.isEmpty else {
            return
        }
        let restaurant = Restaurant(id: nil, name: name, address: address)
        delegate?.didAddRestaurant(restaurant)
        dismiss(animated: true)
    }
}
