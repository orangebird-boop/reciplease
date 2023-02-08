import XCTest
@testable import Application

final class RecipeDetailsViewModelTests: XCTestCase {
    var viewModel: RecipeDetailsViewModel!
    var coreDataManager: CoreDataManager!
  
    
    override func setUp() {
        coreDataManager = CoreDataManager()
        
        viewModel = RecipeDetailsViewModel(recipe: Recipe.init(name: "", foodImage: "", url: "", ingredientLines: [], totalTime: 1))
    }
    
    override func tearDown() {
        coreDataManager.deleteAllFavorites()
    }
    
    func test_ShouldInitialRecipeStateOnNotFavorite() {
        viewModel.checkIfRecipeFavorite()
        
        XCTAssertTrue(viewModel.recipeState == .isNotFavorite)
    }
    
    func test_ShouldToggleFavoriteStatus() {
        let recipe = Recipe(name: "", foodImage: "", url: "", ingredientLines: [], totalTime: 1)
        
        viewModel.toggelFavoriteStatus(for: recipe)
        viewModel.checkIfRecipeFavorite()
        
        XCTAssertTrue(viewModel.recipeState == .isFavorite)
        
        viewModel.toggelFavoriteStatus(for: recipe)
        viewModel.checkIfRecipeFavorite()
        
        XCTAssertTrue(viewModel.recipeState == .isNotFavorite)
    }
    
    func test_ShouldAddRecipeInFavorites() {
        coreDataManager.createFavorite(title: "", ingredients: "", totalTime: 1, image: "", url: "")
        viewModel.checkIfRecipeFavorite()
        
        XCTAssertTrue(viewModel.recipeState == .isFavorite)
    }
    
//    func test_ShouldCheckIfRecipeIsFavorite() {
//
//    }
    
}
