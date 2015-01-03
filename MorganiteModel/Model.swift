import Foundation
import CoreData

class Model: NSManagedObject {
    
    @NSManaged var someDataA: String
    @NSManaged var someDataB: NSNumber
    
}