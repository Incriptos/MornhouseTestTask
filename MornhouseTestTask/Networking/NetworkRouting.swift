import Alamofire
import Foundation

enum HTTPHeaderField: String {
  case authentication = "Authorization"
  case contentType = "Content-Type"
  case acceptType = "Accept"
  case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
  case json = "application/json"
  case urlencoded = "application/x-www-form-urlencoded"
  case textHtml = "text/html"
  case multipart = "multipart/form-data"
}

enum Router: URLRequestConvertible {
  case random_math_number, exact_number(number: String)
  
  var httpMethod: HTTPMethod {
    switch self {
    case .random_math_number, .exact_number:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers: HTTPHeaders = []
    switch self {
    case .random_math_number, .exact_number:
      headers.add(name: HTTPHeaderField.contentType.rawValue, value: ContentType.json.rawValue)
    }
    return headers
  }
  
  var query: String {
    switch self {
    case .exact_number(let number):
      return number
    default:
      return ""
    }
  }
  
  var endPoint: String {
    switch self {
    case .random_math_number:
      return API.Endpoint.random_math_number
    case .exact_number:
      return API.Endpoint.exact_number
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let baseUrl = API.baseURL
    let url = "\(baseUrl)" + (query.isEmpty ? "\(endPoint)" : "\(endPoint)\(query)")
    guard let requestUrl = URL(string: url) else { throw APIError.requestFailed }
    var request = URLRequest(url: requestUrl)
    request.httpMethod = httpMethod.rawValue
    request.headers = headers
    return request
  }
    
}
