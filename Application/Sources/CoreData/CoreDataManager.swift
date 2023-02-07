import CoreData

class CoreDataManager {
    
    // MARK: - Properties
    #if TEST
    static let dataModelFilename = "RecipleaseDataModelTest"
    #else
    static let dataModelFilename = "RecipleaseDataModel"
    #endif
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
    
    // MARK: - Functions

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
    
    func createFavorite(title: String, ingredients: String, totalTime: Int32, image: String, url: String, completionHandler: ((Bool) -> Void)? = nil) {
        guard let description = NSEntityDescription.entity(forEntityName: "RecipeEntity", in: Self.context) else {
            fatalError("Failed to retrieve entity description")
        }
        
        let recipe = RecipeEntity(entity: description, insertInto: Self.context)
        recipe.recipeName = title
        recipe.recipeIngredients = ingredients
        recipe.recipeTotalTime = totalTime
        recipe.recipeFoodImage = image
        recipe.recipeUrl = url
        saveContext()
        
        completionHandler?(true)
    }
    
    func getFavorites() -> [Recipe] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        
        do {
            let entities = try Self.context.fetch(request)
            
            return entities.map { $0.toGenericModel() }
            
        } catch {
            fatalError("userfriendly message")
        }
    }
    
    func checkIfRecipeFavorite(name: String, url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "recipeUrl == %@", url)
        
        guard let numberOfFavorites = try? Self.context.count(for: request) else {return false}
        return numberOfFavorites != 0 
    }
    
    func deleteFavorite(name: String, url: String, completionHandler: ((Bool) -> Void)? = nil) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "recipeUrl == %@", url)

        do {
            let entity = try Self.context.fetch(request)
            
            entity.forEach { Self.context.delete($0) }
            
        } catch {
            fatalError("userfriendly message")
        }
        
        saveContext()
        
        completionHandler?(true)
    }
    
    func deleteAllFavorites() {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()

        do {
            let entity = try Self.context.fetch(request)
            
            entity.forEach { Self.context.delete($0) }
            
        } catch {
            fatalError("userfriendly message")
        }
        
        saveContext()
    }
}
