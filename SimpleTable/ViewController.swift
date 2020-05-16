//
//  ViewController.swift
//  SimpleTable
//
//  Created by  Karol Moroz on 2020/5/16.
//  Copyright © 2020  Karol Moroz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var products = [GetProductsQuery.Data.Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()
        // Do any additional setup after loading the view.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = products[indexPath.row].name
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
                
              }

              switch result {
              case .success(let graphQLResult):
                  if let productConnection = graphQLResult.data?.products {
                    self.products.append(contentsOf: productConnection.compactMap { $0 })
                    print(self.products)
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

