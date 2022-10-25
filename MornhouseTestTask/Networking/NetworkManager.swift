import Alamofire
import Foundation

enum APIError: Error {
  case requestFailed
  case jsonConversionFailure
  case invalidData
  case responseUnsuccessful
  case jsonParsingFailure
  var localizedDescription: String {
    switch self {
    case .requestFailed: return "Request Failed"
    case .invalidData: return "Invalid Data"
    case .responseUnsuccessful: return "Response Unsuccessful"
    case .jsonParsingFailure: return "JSON Parsing Failure"
    case .jsonConversionFailure: return "JSON Conversion Failure"
    }
  }
}

final class NetworkManager {
  
  static let shared = NetworkManager()
  
  private var session = Alamofire.Session.default
  
  private var unauthorizedSession = Alamofire.Session(configuration: .ephemeral, delegate: SessionDelegate(), serverTrustManager: .none)
  
  private init() {
    self.session.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
  }
}

extension NetworkManager {
  
  /// GET random math number
  func getRandomNumber(
    onStart: @escaping () -> Void,
    onFinish: @escaping () -> Void,
    completion: @escaping (Result<NumberModel, APIError>) -> Void
  ) {
    onStart()
    session
      .request(Router.random_math_number)
      .responseDecodable(of: NumberModel.self, queue: .main) { result in
        switch result.result {
        case .success(let result):
          completion(.success(result))
        case .failure(let error):
          debugPrint(error)
          completion(.failure(.responseUnsuccessful))
        }
        onFinish()
      }
  }
  
  /// GET exact_number
  func getNumber(
    number: String,
    onStart: @escaping () -> Void,
    onFinish: @escaping () -> Void,
    completion: @escaping (Result<NumberModel, APIError>) -> Void
  ) {
    onStart()
    session
      .request(Router.exact_number(number: number))
      .responseDecodable(of: NumberModel.self, queue: .main) { result in
        switch result.result {
        case .success(let result):
          completion(.success(result))
        case .failure(let error):
          debugPrint(error)
          completion(.failure(.responseUnsuccessful))
        }
        onFinish()
      }
  }
  
}
