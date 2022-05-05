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
    
    private let searchService: EdamamSearchService
    private (set) var ingredients: [String] = []
    private (set) var recipes: [EdamamRecipe] = []
    weak var delegate: SearchViewModelDelegate?
    
    init(searchService: EdamamSearchService = EdamamSearchService()) {
        self.searchService = searchService
    }
    
    func deleteIngredient(index: Int) {
        ingredients.remove(at: index)
        
        delegate?.didUpgradeIngredients()
    }
    
    func add(ingredient: String) {
        ingredients.append(ingredient)
        
        delegate?.didUpgradeIngredients()
    }
    func searchRecipes(ingredients: [String]) {
        
        searchService.getRecipes(ingredients: ingredients.joined(separator: "%2C%20"), page: 0) { [weak self] result in
            switch result {
            case.success(let response):
                dump(response)
                
                self?.recipes = response.hits.compactMap { $0.recipe }
                self?.delegate?.didFindRecipes()
                
            case.failure(let error):
                dump(error)
//                delegate?.didNotFindRecipe(error: error)
//
//                switch error {
//
//                case .invalidURL, networkError:
//                    delegate?.didNotFindRecipe(error: .failedToRetrieveRecipes)
//
//                case .invalidData, invalidResponse, invalidJSONStructure:
//                    delegate?.didNotFindRecipe(error: .defaultError)
//                
//                }
            }
        }
    }
}
