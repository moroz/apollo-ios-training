//
//  Network.swift
//  SimpleTable
//
//  Created by  Karol Moroz on 2020/5/17.
//  Copyright © 2020  Karol Moroz. All rights reserved.
//

import Foundation
import Apollo

let graphQLEndpoint = "https://api.rocketsto.re/"

class Network {
    static let shared = Network()

    private(set) lazy var apollo = ApolloClient(url: URL(string: graphQLEndpoint)!)
}
