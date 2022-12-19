import Foundation

class FavoritesViewModel: RecipesViewModelProtocol {
    
    weak var delegate: RecipesViewModelDelegate?
    
    let coreDataManager: CoreDataManager
    private (set) var recipes: [Recipe] = []
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }

    func getRecipes() -> [Recipe] {
        recipes = self.coreDataManager.getFavorites()
        
        return recipes
    }
}
