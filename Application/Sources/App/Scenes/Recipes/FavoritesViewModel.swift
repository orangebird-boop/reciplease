import Foundation

class FavoritesViewModel: RecipesViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: RecipesViewModelDelegate?
    
    let coreDataManager: CoreDataManager
    private (set) var recipes: [Recipe] = []
    
    // MARK: - Initialization
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Functions
    
    func getRecipes() -> [Recipe] {
        recipes = self.coreDataManager.getFavorites()
        
        return recipes
    }
}
