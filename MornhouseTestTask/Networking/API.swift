import Foundation

enum API {
  static let baseURL: String = "http://numbersapi.com"
  
  enum Endpoint {
    static let exact_number = "/"
    static let random_math_number: String = "/random/math"
  }
}
