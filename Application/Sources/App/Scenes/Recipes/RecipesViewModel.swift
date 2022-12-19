import Foundation

class RecipesViewModel: RecipesViewModelProtocol {
    
    let searchService: EdamamSearchService
    private var recipes: [Recipe]
    private var nextURL: String?
    weak var delegate: RecipesViewModelDelegate?
    
    init(searchService: EdamamSearchService = .init(), recipes: [Recipe], nextURL: String? = nil) {
        self.searchService = searchService
        self.recipes = recipes
        self.nextURL = nextURL
    }
    
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
                
           
                self.recipes +=  recipeResponse.recipes
                self.nextURL = recipeResponse.nextLink?.href
                self.delegate?.didFindRecipes()
                
            case.failure(_):
                self.delegate?.noMoreRecipesToLoad()
            }
        }
    }
}
