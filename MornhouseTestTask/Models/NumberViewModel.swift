import Foundation
import RealmSwift

protocol Persistable {
  func toPersistable() -> Object?
}

struct NumberViewModel {
  let id: ObjectId?
  let number: Int
  let text: String
      
  init(_ object: NumberObject) {
    self.id = object.id
    self.number = object.number
    self.text = object.text
  }
  
}
