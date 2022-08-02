import CoreData

final class CoreDataManager {
    // MARK: - Core Data stack
    var container: NSPersistentContainer
    var context: NSManagedObjectContext
    init(name: String) {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
           
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = container.viewContext
    }
                                    
                                    
    // MARK: - Core Data Saving support

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
