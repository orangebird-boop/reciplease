import XCTest
@testable import Application

final class RecipesViewModelTest: XCTestCase {
    var viewModel: RecipesViewModel!
    
    var service: EdamamSearchService!
    var stubNetworkManager: StubNetworkManager!
    var observer: RecipesViewModelObserver!
  
    
    override func setUp() {
          stubNetworkManager = StubNetworkManager()
          service = EdamamSearchService(networkService: stubNetworkManager)
        
        observer = RecipesViewModelObserver()
        viewModel = RecipesViewModel(recipes: [Recipe(name: "Title", foodImage: "image", url: "http://www.google.com", ingredientLines: [], totalTime: 1)])
        viewModel.delegate = observer
        
      }
    
    func test_ShouldGetRecipes() {
        XCTAssertEqual(viewModel.getRecipes().count, 0)
    }
    
    func test_ShouldLoadMoreRecipes() {
        viewModel.loadMoreRecipes()
        service.getRecipes(nextSet: "http://www.google.com") {_ in
           
    }

}

class RecipesViewModelObserver: RecipesViewModelDelegate {
    
    var foundRecipes = false
    var noMoreToLoad = false
    
    func didFindRecipes() {
        foundRecipes = true
    }
    
    func noMoreRecipesToLoad() {
        noMoreToLoad = true
    }
    
    
}
