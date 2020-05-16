//
//  ProductsTableViewController.swift
//  SimpleTable
//
//  Created by  Karol Moroz on 2020/5/17.
//  Copyright © 2020  Karol Moroz. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class ProductsTableViewController: UITableViewController {
    var products = [GetProductsQuery.Data.Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductTableViewCell
        
        let product = products[indexPath.row]
        if let imageUrl = product.imageUrl {
            let url = URL(string: imageUrl)
            cell.productImageView.load(url: url!)
        }
        cell.productNameLabel?.text = product.name
        let basePrice = product.basePrices.first?.amount ?? "0"
        let rounded = (basePrice as NSString).floatValue
        cell.productPriceLabel?.text = "NT$\(rounded)"
       
                
        return cell
    }


    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }


    private func loadProducts() {
        Network.shared.apollo
          .fetch(query: GetProductsQuery()) { [weak self] result in

              guard let self = self else {
                  return
              }

             defer {
                self.tableView.reloadData()
             }

              switch result {
              case .success(let graphQLResult):
                  if let productConnection = graphQLResult.data?.products {
                    self.products.append(contentsOf: productConnection.compactMap { $0 })
                  }

                  if let errors = graphQLResult.errors {
                      let message = errors
                        .map { $0.localizedDescription }
                        .joined(separator: "\n")
                      self.showErrorAlert(title: "GraphQL Error(s)", message: message)
                  }
              case .failure(let error):
                  self.showErrorAlert(title: "Network Error",
                                      message: error.localizedDescription)
              }
          }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
