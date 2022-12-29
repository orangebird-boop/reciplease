import Foundation

enum SearchViewModelError: LocalizedError {
    case failedToRetrieveRecipes
    case defaultError
    case failedToUpdateIngredients
//    case ingredientError
    
    var helpAnchor: String? {
        switch self {
        case .failedToRetrieveRecipes: return "Failed to retrive recipes"
        case .defaultError: return "An error occured, please contact our support team on the following adresse: support@reciplease.com"
        case .failedToUpdateIngredients: return "This ingredient is already in your list"
//        case .ingredientError: return "Failed to retrive recipes, an ingredient is not valid"
        }
    }
}
protocol SearchViewModelDelegate: AnyObject {
    func didUpdateIngredients()
    func didNotUpdateIngredients(error: SearchViewModelError)
    func didFindRecipes()
    func didNotFindRecipe(error: SearchViewModelError)
    func noMatch()
}

class SearchViewModel {
    
    let searchService: EdamamSearchService
    var ingredients: [String] = []
    private (set) var recipes: [Recipe] = []
    private (set) var nextUrl: String?
    weak var delegate: SearchViewModelDelegate?
    
    init(searchService: EdamamSearchService = EdamamSearchService()) {
        self.searchService = searchService
    }
    
    func delete(ingredient: String) {
        ingredients.removeAll { $0 == ingredient }
        
        delegate?.didUpdateIngredients()
    }
    
    func add(ingredient: String) {
       
        if ingredients.contains(ingredient) {
            delegate?.didNotUpdateIngredients(error: .failedToUpdateIngredients)
        } else {
            ingredients.append(ingredient)
            delegate?.didUpdateIngredients()
        }
    }
    
    func clearAll() {
        ingredients.removeAll()
        delegate?.didUpdateIngredients()
    }
    
    func searchRecipes() {
        guard !ingredients.isEmpty else {
            
            return
        }
        searchService.getRecipes(ingredients: ingredients, page: 0) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case.success(let recipeResponse):
                
                self.clearAll()
                self.recipes = recipeResponse.recipes
                self.nextUrl = recipeResponse.nextLink?.href
                self.delegate?.didFindRecipes()
                
            case.failure(let error):
                switch error {

                case .invalidURL, .networkError:
                    self.delegate?.didNotFindRecipe(error: .failedToRetrieveRecipes)

                case .invalidData, .invalidResponse, .invalidJSONStructure:
                    self.delegate?.didNotFindRecipe(error: .defaultError)
                
                default:
                    self.delegate?.noMatch()
                
                }
            }
        }
    }
}
