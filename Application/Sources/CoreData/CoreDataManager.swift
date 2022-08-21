import CoreData

final class CoreDataManager {
    
    private let dataModelFilename = "RecipleaseDataModel"
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack
    private var container: NSPersistentContainer
    private var context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: dataModelFilename)
        
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
    
    // MARK: - Manage Task Entity
    
    func createFavorite(title: String, ingredients: String, totalTime: Int64, image: String, url: String) {
        guard let description = NSEntityDescription.entity(forEntityName: "RecipeEntity", in: context) else {
            fatalError("Failed to retrieve entity description")
        }
        
        let recipe = RecipeEntity(entity: description, insertInto: context)
        recipe.name = title
        recipe.ingredients = ingredients
        recipe.totalTime = totalTime
        recipe.foodImage = image
        recipe.url = url
        saveContext()
    }
    
    func checkIfRecipeFavorite(name: String, url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.predicate = NSPredicate(format: "url == %@", url)
        
        guard let numberOfFavorites = try? context.count(for: request) else {return false}
        return numberOfFavorites != 0 
    }
    
    func deleteFavorite(name: String, url: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.predicate = NSPredicate(format: "url == %@", url)
        
        if let entity = try? context.fetch(request) {
            entity.forEach {context.delete($0)}
        }
        saveContext()
    }
}
