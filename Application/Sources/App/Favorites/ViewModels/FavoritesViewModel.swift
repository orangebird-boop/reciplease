import Foundation

class FavoritesViewModel {
    
    var recipes = [Recipe]()
    var coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
}
