import XCTest
@testable import Application

final class RecipeDetailsViewModelTests: XCTestCase {
    var viewModel: RecipeDetailsViewModel!
    var coreDataManager: CoreDataManager!
    
    var observer: RecipesDetailsViewModelObserver!
    var recipeState: RecipeState = .isNotFavorite {
        didSet {
            observer?.didToggleFavoriteStatusForRecipe(state: recipeState)
        }
    }
    
    override func setUp() {
        coreDataManager = CoreDataManager()
        
        coreDataManager.createFavorite(title: "", ingredients: "", totalTime: 1, image: "", url: "") {_ in
        }
        viewModel = RecipeDetailsViewModel(recipe: Recipe.init(name: "", foodImage: "", url: "", ingredientLines: [], totalTime: 1))
    }
    
    
    func test_ShouldToggleFavoriteStatus() {
        
    }
    
    func test_ShouldAddRecipeInFavorites() {
        
    }
    
    func test_ShouldCheckIfRecipeIsFavorite() {
        
    }
    
    
    class RecipesDetailsViewModelObserver: RecipeDetailsViewModelDelegate {
        func didToggleFavoriteStatusForRecipe(state: Application.RecipeState) {
            recipeState = coreDataManager.checkIfRecipeFavorite(name: recipe.name, url: recipe.url) ? .isFavorite : .isNotFavorite
            
        }
        
       
        
        
        
    
        
        
    }
    
}
