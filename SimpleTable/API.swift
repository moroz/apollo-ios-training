// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetProductsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getProducts {
      products {
        __typename
        id
        name
        inStock
        basePrices {
          __typename
          currencyId
          amount
        }
        description
        imageUrl(size: THUMB_2X)
        slug
      }
    }
    """

  public let operationName: String = "getProducts"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["RootQueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("products", type: .nonNull(.list(.nonNull(.object(Product.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(products: [Product]) {
      self.init(unsafeResultMap: ["__typename": "RootQueryType", "products": products.map { (value: Product) -> ResultMap in value.resultMap }])
    }

    public var products: [Product] {
      get {
        return (resultMap["products"] as! [ResultMap]).map { (value: ResultMap) -> Product in Product(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Product) -> ResultMap in value.resultMap }, forKey: "products")
      }
    }

    public struct Product: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Product"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("inStock", type: .scalar(Bool.self)),
        GraphQLField("basePrices", type: .nonNull(.list(.nonNull(.object(BasePrice.selections))))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("imageUrl", arguments: ["size": "THUMB_2X"], type: .scalar(String.self)),
        GraphQLField("slug", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, inStock: Bool? = nil, basePrices: [BasePrice], description: String? = nil, imageUrl: String? = nil, slug: String) {
        self.init(unsafeResultMap: ["__typename": "Product", "id": id, "name": name, "inStock": inStock, "basePrices": basePrices.map { (value: BasePrice) -> ResultMap in value.resultMap }, "description": description, "imageUrl": imageUrl, "slug": slug])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var inStock: Bool? {
        get {
          return resultMap["inStock"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "inStock")
        }
      }

      public var basePrices: [BasePrice] {
        get {
          return (resultMap["basePrices"] as! [ResultMap]).map { (value: ResultMap) -> BasePrice in BasePrice(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: BasePrice) -> ResultMap in value.resultMap }, forKey: "basePrices")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var imageUrl: String? {
        get {
          return resultMap["imageUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "imageUrl")
        }
      }

      public var slug: String {
        get {
          return resultMap["slug"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "slug")
        }
      }

      public struct BasePrice: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Price"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("currencyId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("amount", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(currencyId: GraphQLID, amount: String) {
          self.init(unsafeResultMap: ["__typename": "Price", "currencyId": currencyId, "amount": amount])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var currencyId: GraphQLID {
          get {
            return resultMap["currencyId"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "currencyId")
          }
        }

        public var amount: String {
          get {
            return resultMap["amount"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "amount")
          }
        }
      }
    }
  }
}
