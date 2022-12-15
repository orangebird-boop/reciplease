import Foundation

enum RecipesViewModelError: LocalizedError {
    case failedToRetrieveRecipes
    case defaultError
    
    var helpAnchor: String? {
        switch self {
        case .failedToRetrieveRecipes: return "Failed to retrive recipes"
        case .defaultError: return "An error occured, please contact our support team on the following adresse: support@reciplease.com"
        }
    }
}
protocol RecipesViewModelDelegate: AnyObject {
    func didNotUpdateIngredients(error: RecipesViewModelError)
    func didFindRecipes()
    func didNotFindRecipe(error: RecipesViewModelError)
}

struct RecipesViewModel: RecipesViewModelProtocol {
    
    let searchService: EdamamSearchService
    private var recipes: [Recipe]
    private var nextURL: RecipeNext?
    weak var delegate: RecipesViewModelDelegate?
    
    init(recipes: [Recipe], nextURL: String? = nil) {
        self.recipes = recipes
    }
    
    func getRecipes() -> [Recipe] {
        recipes
    }
    
    func loadMoreRecipes() {
        guard nextURL.href != nil else {
            
            return
        }
        searchService.getRecipes(nextSet: nextURL.href) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case.success(let recipeResponse):
                
           
//                self.recipes = recipeResponse.recipes
                self.nextURL = recipeResponse.nextLink?.href
                self.delegate?.didFindRecipes()
                
            case.failure(let error):
                switch error {

                case .invalidURL, .networkError:
                    self.delegate?.didNotFindRecipe(error: .failedToRetrieveRecipes)

                case .invalidData, .invalidResponse, .invalidJSONStructure:
                    self.delegate?.didNotFindRecipe(error: .defaultError)
                
                }
            }
        }
    }
}
