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
    private (set) var ingredients: [RecipeIngredient] = []
    private (set) var recipes: [Recipe] = []
    weak var delegate: SearchViewModelDelegate?

    init(searchService: EdamamSearchService = EdamamSearchService()) {
        self.searchService = searchService
    }
    
    func delete(ingredient: RecipeIngredient) {
        ingredients.removeAll(where: { $0 == ingredient })
        
        delegate?.didUpgradeIngredients()
    }
    
    func add(ingredient: String) {
        guard !ingredients.contains(where: { $0.text == ingredient }) else {
            return
        }

        ingredients.append(RecipeIngredient(text: ingredient))

        delegate?.didUpgradeIngredients()
    }

    func removeAllIngredients() {
        ingredients.removeAll()

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
