//
//  WineListViewController.swift
//  ios101-wine-knot
//
//  Created by Natalie Chan on 8/5/25.
//

import UIKit

class WineListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var wines: [Wine] = []
    
    var selectedRestaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedRestaurant?.name ?? "Wine List"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WineCell")

        fetchWines()
    }

    private func fetchWines() {
        guard let url = URL(string: "http://127.0.0.1:8000/wines/wines/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    //print("Response JSON: \(jsonString)")
                }
                do {
                    let wines = try JSONDecoder().decode([Wine].self, from: data)
                    if let restaurantId = self.selectedRestaurant?.id {
                        self.wines = wines.filter { $0.restaurant == restaurantId }
                        print("restaurant id: \(restaurantId)")
                        print("Count: \(self.wines.count)")
                    } else {
                        self.wines = wines
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else {
                print("Network error:", error?.localizedDescription ?? "Unknown error")
            }
        }
        task.resume()
    }
   }

   // MARK: - Table View Delegate & Data Source
   extension WineListViewController: UITableViewDelegate, UITableViewDataSource {

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return wines.count
       }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wine = wines[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell", for: indexPath)

        var content = cell.defaultContentConfiguration()        
        content.text = wine.name
        cell.contentConfiguration = content
        return cell
    }
       

}
