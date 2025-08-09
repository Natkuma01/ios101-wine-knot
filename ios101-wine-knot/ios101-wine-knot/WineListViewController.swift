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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wine List"

        tableView.delegate = self
                tableView.dataSource = self
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WineCell")

                fetchWines()
    }

    private func fetchWines() {
           guard let url = URL(string: "https://premium-wine-api-collection.p.rapidapi.com/rapidapi/wine/wine_pagination.php?page_no=2") else { return }

           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           request.setValue("2ae60dd531msh63911a58f3f78b8p1752fajsnc35a8a2ef260", forHTTPHeaderField: "X-RapidAPI-Key")
           request.setValue("premium-wine-api-collection.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let data = data {
                   do {
                       let result = try JSONDecoder().decode(WineResponse.self, from: data)
                       self.wines = result.wines
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
        
        let title = wine.title
        let cleanedTitle = title.replacingOccurrences(of: "\\s*\\([^\\)]*\\)$", with: "", options: .regularExpression)
        
        content.text = cleanedTitle
        cell.contentConfiguration = content
        return cell
    }
       

}
