import Foundation

struct FavoritesViewModel: RecipesViewModelProtocol {
    
    let coreDataManager : CoreDataManager
    private let recipes: [Recipe]
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
        
        recipes = self.coreDataManager.getFavorites()
        
    }
    
    func getRecipes() -> [Recipe] {
        return []
    }
}
