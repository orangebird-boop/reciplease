import XCTest
@testable import Application

final class SearchViewModelTest: XCTestCase {
    var viewModel: SearchViewModel!
    var service: EdamamSearchService!
    var stubNetworkManager: StubNetworkManager!
    var observer: SearchViewModelObserver!

    
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }
    
    override func setUp() {
        stubNetworkManager = StubNetworkManager()
        service = EdamamSearchService(networkService: stubNetworkManager)
        
        observer = SearchViewModelObserver()
        viewModel = SearchViewModel(searchService: service)
        viewModel.delegate = observer
    }
    
    func test_ShouldDeletesIngredients() {
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.delegate = observer
        viewModel.delete(ingredient: "apple")
        
        XCTAssertEqual(viewModel.ingredients, ["pen", "pinapple"])
        
    }
    
    func test_ShouldAddIngredient(){
        viewModel.delegate = observer
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.add(ingredient: "applepen")
        
        XCTAssertEqual(viewModel.ingredients, ["pen", "apple", "pinapple", "applepen"])
    }
    
    func test_ShouldNotAddDuplicatedIngredient() {
        viewModel.delegate = observer
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.add(ingredient: "pen")
        
        XCTAssertEqual(viewModel.ingredients.count, 3)
        XCTAssertEqual(observer.didNotUpdateError, .failedToUpdateIngredients)
    }
    
    func test_ShouldClearAll(){
        viewModel.delegate = observer
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.clearAll()
        
        XCTAssertEqual(viewModel.ingredients, [])
    }
    
    func test_ShouldSearchRecipes(){
        viewModel.delegate = observer
        
        let response = EdamamResponse(hits: [Hit(recipe: EdamamRecipe(label: "", image: "", url: "", ingredientLines: [], totalTime: 1), link: EdamamLink(href: ""))] )
        
        stubNetworkManager.stubData = response
        service.getRecipes(ingredients: []) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure:
                XCTFail("It shouldn't fail")
            }
        }
    }
    
    func test_ShouldUpdateIngredients() {
        viewModel.delegate = observer
       
        let response = EdamamResponse(hits: [Hit(recipe: EdamamRecipe(label: "", image: "", url: "", ingredientLines: [], totalTime: 1), link: EdamamLink(href: ""))] )
        viewModel.add(ingredient: "apple")
        
        stubNetworkManager.stubData = response
        service.getRecipes(ingredients: []) { result in
            switch result {
            case .success(_):
                XCTAssertTrue(self.observer.updateIngredients)
            case .failure:
                XCTFail("It shouldn't fail")
            }
        }
    }
    
    func test_ShouldReturnDidNotFindRecipe() {
        viewModel.delegate = observer
        
        stubNetworkManager.stubError = NetworkManagerError.emptyData
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.searchRecipes()
        
        XCTAssertEqual(observer.didNotFindRecipesError, .failedToRetrieveRecipes)
    }
}

class SearchViewModelObserver: SearchViewModelDelegate {
    
    var updateIngredients = false
    var findRecipes = false
    var didNotUpdateError: Application.SearchViewModelError? = nil
    var didNotFindRecipesError: Application.SearchViewModelError? = nil
    
    func didUpdateIngredients() {
        updateIngredients = true
    }
    

    
    func didNotUpdateIngredients(error: Application.SearchViewModelError) {
        didNotUpdateError = error

    }
    
    func didFindRecipes() {
        findRecipes = true
    }
    
    func didNotFindRecipe(error: Application.SearchViewModelError) {
        didNotFindRecipesError = error
    }
    
  
}
