import Foundation

class FavoritesViewModel: RecipesViewModelProtocol {
    let navigationTitle = "Favorites"
    
    var buttonState: Bool
    
    
    // MARK: - Properties
    
    weak var delegate: RecipesViewModelDelegate?
    
    let coreDataManager: CoreDataManager
    private (set) var recipes: [Recipe] = []
  
    
    // MARK: - Initialization
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
        self.buttonState = true
    }
    
    // MARK: - Functions
    
    func getRecipes() -> [Recipe] {
        recipes = self.coreDataManager.getFavorites()
        self.buttonState = true
        return recipes
    }
}
