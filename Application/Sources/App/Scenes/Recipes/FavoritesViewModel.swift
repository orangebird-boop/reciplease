import Foundation

class FavoritesViewModel: RecipesViewModelProtocol {
    
    let coreDataManager: CoreDataManager
    private (set) var recipes: [Recipe] = []
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }

    func getRecipes() -> [Recipe] {
        recipes = self.coreDataManager.getFavorites()
        
        return recipes
    }
    
    func countRecipes() -> Int {
        let numberOfRecipes = recipes.count
        return numberOfRecipes
    }
}
