import CoreData

final class CoreDataManager {
   
    private static let dataModelFilename = "RecipleaseDataModel"
    static let shared = CoreDataManager()
    
      static var container: NSPersistentContainer = {
          let container = NSPersistentContainer(name: dataModelFilename)

          container.loadPersistentStores { (_, error) in
              if let error = error as NSError? {

                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          }

          return container
      }()

      static var context: NSManagedObjectContext = {
          container.viewContext
      }()

      func saveContext() {
          if Self.context.hasChanges {
              do {
                  try Self.context.save()
              } catch {

                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
    
    // MARK: - Manage Task Entity
    
    func createFavorite(title: String, ingredients: String, totalTime: Int64, image: String, url: String, completionHandler: @escaping (Bool) -> Void) {
        guard let description = NSEntityDescription.entity(forEntityName: "RecipeEntity", in: Self.context) else {
            fatalError("Failed to retrieve entity description")
        }
        
        let recipe = RecipeEntity(entity: description, insertInto: Self.context)
        recipe.name = title
        recipe.ingredients = ingredients
        recipe.totalTime = totalTime
        recipe.foodImage = image
        recipe.url = url
        saveContext()
		
		completionHandler(true)
    }
	
	func getFavorites() -> [Recipe] {
		let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
		
		do {
			let entities = try Self.context.fetch(request)
			
			
			return entities.map { $0.toGenericModel() }
		} catch {
			fatalError("REPLACE WITH USER FRIENDLY ERROR")
		}
	}
    
    func checkIfRecipeFavorite(name: String, url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        guard let numberOfFavorites = try? Self.context.count(for: request) else {return false}
        return numberOfFavorites != 0 
    }
    
	func deleteFavorite(name: String, url: String, completionHandler: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
		
		do {
			let entity = try Self.context.fetch(request)
			
			entity.forEach { Self.context.delete($0) }
		} catch {
			fatalError("REPLACE WITH USER FRIENDLY ERROR")
		}
        
        saveContext()
		
		completionHandler(true)
    }
}
