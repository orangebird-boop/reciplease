import XCTest
@testable import Application

final class RecipesViewModelTest: XCTestCase {
    let viewModel = RecipesViewModel(recipes: [])
    
    var service: EdamamSearchService!
    var stubNetworkManager: StubNetworkManager!
    let observer = SearchViewModelObserver()
    let model = Recipe.init(name: "PPAP", foodImage: nil, url: "https://www.google.com", ingredientLines: ["pen", "apple", "pinapple"], totalTime: nil)
    
    override func setUp() {
          stubNetworkManager = StubNetworkManager()
          service = EdamamSearchService(networkService: stubNetworkManager)
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
