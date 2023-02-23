import Foundation

class RecipesViewModel: RecipesViewModelProtocol {
 
    // MARK: - Properties
    
    let searchService: EdamamSearchService
    private (set) var recipes: [Recipe]
    private (set) var nextURL: String?
    weak var delegate: RecipesViewModelDelegate?
    var navigationTitle: String
    var buttonState: Bool
 
    
    // MARK: - Initialization
    
    init(searchService: EdamamSearchService = .init(), recipes: [Recipe], nextURL: String? = nil) {
        self.searchService = searchService
        self.recipes = recipes
        self.nextURL = nextURL
        self.buttonState = false
        self.navigationTitle = "Recipes"
    }
    
    // MARK: - Functions
    
    func getRecipes() -> [Recipe] {
        recipes
    }
    
    func loadMoreRecipes() {
        guard let nextURL else {
            delegate?.noMoreRecipesToLoad()
            return
        }
        searchService.getRecipes(nextSet: nextURL) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case.success(let recipeResponse):
                self.buttonState = false
                self.recipes +=  recipeResponse.recipes
                self.nextURL = recipeResponse.nextLink?.href
                self.delegate?.didFindRecipes()
                
            case.failure:
                self.delegate?.noMoreRecipesToLoad()
            }
        }
    }
}
