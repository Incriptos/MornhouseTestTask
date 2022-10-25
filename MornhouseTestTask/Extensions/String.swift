import Foundation

extension String {
  
  var intValue: Int {
    return (self as NSString).integerValue
  }
  
  func isEmptyOrWhitespace() -> Bool {
    if self.isEmpty { return true }
    return self.trimmingCharacters(in: CharacterSet.whitespaces) == ""
  }
  
  func isNumberOrEmpty() -> Bool {
    if isEmpty { return true }
    return isNumber()
  }
  
  func isNumber() -> Bool {
    if Int(self) == nil { return false }
    return true
  }
  
}
