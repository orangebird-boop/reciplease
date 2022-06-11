import Foundation

enum SearchViewModelError: LocalizedError {
    case failedToRetrieveRecipes
    case defaultError
    
    var helpAnchor: String? {
        switch self {
        case .failedToRetrieveRecipes: return "Failed to retrive recipes"
        case .defaultError: return "An error occured, please contact our support team on the following adresse: support@reciplease.com"
        }
    }
}
protocol SearchViewModelDelegate: AnyObject {
    func didUpgradeIngredients()
    func didFindRecipes()
    func didNotFindRecipe(error: SearchViewModelError)
}
class SearchViewModel {
    
     let searchService: EdamamSearchService
//    var recipeIngredients: [RecipeIngredients] = []
    var ingredients: [RecipeIngredient] = []
    private (set) var recipes: [Recipe] = []
    weak var delegate: SearchViewModelDelegate?
    
//    init(recipeIngredients: [RecipeIngredients]) {
//        self.recipeIngredients = recipeIngredients
//
//    }
    
    init(searchService: EdamamSearchService = EdamamSearchService()) {
        self.searchService = searchService
    }
    
    func deleteIngredient(index: Int) {
        ingredients.remove(at: index)
        
        delegate?.didUpgradeIngredients()
    }
    
    func add(ingredient: String) {
        ingredients.append(RecipeIngredient(text: ingredient))
//        recipeIngredients.append(ingredient)
        delegate?.didUpgradeIngredients()
    }
    func searchRecipes() {
        
        searchService.getRecipes(ingredients: ingredients.map { $0.text }, page: 0) { [weak self] result in
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
