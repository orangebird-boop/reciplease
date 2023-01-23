import CoreData
@testable import Application

class TestCoreDataStack: CoreDataManager {
  override init() {
    super.init()

    
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType

  
      var container: NSPersistentContainer = {
          let container = NSPersistentContainer(name: TestCoreDataStack.dataModelFilename)

          container.loadPersistentStores { (_, error) in
              if let error = error as NSError? {

                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          }
          
          
          return container
      }()
  }
}
