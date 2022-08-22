import Foundation

enum SearchViewModelError: LocalizedError {
    case failedToRetrieveRecipes
    case defaultError
    case failedToUpdateIngredients
    
    var helpAnchor: String? {
        switch self {
        case .failedToRetrieveRecipes: return "Failed to retrive recipes"
        case .defaultError: return "An error occured, please contact our support team on the following adresse: support@reciplease.com"
        case .failedToUpdateIngredients: return "This ingredient is already in your list"
        }
    }
}
protocol SearchViewModelDelegate: AnyObject {
    func didUpgradeIngredients()
    func didNotUpdateIngredients(error: SearchViewModelError)
    func didFindRecipes()
    func didNotFindRecipe(error: SearchViewModelError)
}

class SearchViewModel {
    
    let searchService: EdamamSearchService
    var ingredients: [String] = []
    private (set) var recipes: [Recipe] = []
    weak var delegate: SearchViewModelDelegate?
    
    init(searchService: EdamamSearchService = EdamamSearchService()) {
        self.searchService = searchService
    }
    
    func deleteIngredient(index: Int) {
        ingredients.remove(at: index)
        
        delegate?.didUpgradeIngredients()
    }
    
    func add(ingredient: String) {
       
        if ingredients.contains(ingredient) {
            delegate?.didNotUpdateIngredients(error: .failedToUpdateIngredients)
        } else {
            ingredients.append(ingredient)
            delegate?.didUpgradeIngredients()
        }
    }
    
    func searchRecipes() {
        guard !ingredients.isEmpty else {
            // TODO: Return message to user
            return
        }
        
        searchService.getRecipes(ingredients: ingredients, page: 0) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case.success(let recipeResponse):

                self.recipes = recipeResponse.recipes
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
