import Foundation
import CoreData

class FavoritesViewModel {
    
    var recipes = [Recipe]()
    var coreDataManager: CoreDataManager
    private weak var fetchedFavoritesControllerDelegate: NSFetchedResultsControllerDelegate?
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
       
    }
    
    lazy var fetchedFavorites: NSFetchedResultsController<RecipeEntity> = {
        let fetchRequest: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        controller.delegate = fetchedFavoritesControllerDelegate
        
        do {
            try controller.performFetch()
        } catch {
            print("Fetch failed")
        }
        
        return controller
    }()
}
