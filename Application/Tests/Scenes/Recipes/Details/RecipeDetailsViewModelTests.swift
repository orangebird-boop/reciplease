import XCTest
@testable import Application

final class RecipeDetailsViewModelTests: XCTestCase {
    var viewModel: RecipeDetailsViewModel!
    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        coreDataManager = CoreDataManager()
        
        coreDataManager.createFavorite(title: "", ingredients: "", totalTime: 1, image: "", url: "") {_ in
        }
        viewModel = RecipeDetailsViewModel(recipe: Recipe.init(name: "", foodImage: "", url: "", ingredientLines: [], totalTime: 1))
    }

}
