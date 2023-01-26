import XCTest
@testable import Application

final class SearchViewModelTest: XCTestCase {
    var viewModel: SearchViewModel!
    var service: EdamamSearchService!
    var stubNetworkManager: StubNetworkManager!
    var observer: SearchViewModelObserver!
    //    let model = Recipe.init(name: "PPAP", foodImage: nil, url: "https://www.google.com", ingredientLines: ["pen", "apple", "pinapple"], totalTime: nil)
    
    override func setUp() {
        stubNetworkManager = StubNetworkManager()
        service = EdamamSearchService(networkService: stubNetworkManager)
        
        observer = SearchViewModelObserver()
        viewModel = SearchViewModel(searchService: service)
        viewModel.delegate = observer
    }
    
    func testDeletesIngredients() {
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.delegate = observer
        viewModel.delete(ingredient: "apple")
        
        XCTAssertEqual(viewModel.ingredients, ["pen", "pinapple"])
        
    }
    
    func testAddIngredient(){
        viewModel.delegate = observer
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.add(ingredient: "applepen")
        
        XCTAssertEqual(viewModel.ingredients, ["pen", "apple", "pinapple", "applepen"])
    }
    
    func testClearAll(){
        viewModel.delegate = observer
        viewModel.ingredients = ["pen", "apple", "pinapple"]
        viewModel.clearAll()
        
        XCTAssertEqual(viewModel.ingredients, [])
    }
    
    func testSearchRecipes(){
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
}

class SearchViewModelObserver: SearchViewModelDelegate {
    var updateIngredients = false
    var findRecipes = false
    var foundNoMatch = false
    
    func didUpdateIngredients() {
        updateIngredients = true
    }
    
    func didNotUpdateIngredients(error: Application.SearchViewModelError) {
        didNotUpdateIngredients(error: error)
    }
    
    func didFindRecipes() {
        findRecipes = true
    }
    
    func didNotFindRecipe(error: Application.SearchViewModelError) {
        didNotUpdateIngredients(error: error)
    }
    
    func noMatch() {
        foundNoMatch = true
    }
}
