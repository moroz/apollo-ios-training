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

class ProductsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var products = [GetProductsQuery.Data.Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadProducts()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                self.tableView?.reloadData()
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
}
