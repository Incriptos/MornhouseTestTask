import Foundation
import RealmSwift

struct NumberModel: Codable {
  let number: Int
  let text: String
}

extension NumberModel: Persistable {
  func toPersistable() -> RealmSwift.Object? {
    let numberObject = NumberObject()
    numberObject.number = self.number
    numberObject.text = self.text
    return numberObject
  }
}
