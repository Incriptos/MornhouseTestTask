import Foundation
import RealmSwift

class NumberObject: Object {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var number: Int
  @Persisted var text: String
}

extension Object {
    
  public func persist(_ completion: (Bool) -> Void) {
    do {
      try save()
      completion(true)
      debugPrint("Object saved")
    } catch (let error) {
      debugPrint(error.localizedDescription)
      completion(false)
    }
  }
    
  private func save() throws {
    let realm = try Realm()
    try realm.write {
      realm.add(self)
    }
  }
  
}
