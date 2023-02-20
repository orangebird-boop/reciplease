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
    func didFindRecipes()
    func noMoreRecipesToLoad()
}

protocol RecipesViewModelProtocol {
    var delegate: RecipesViewModelDelegate? { get set}
    var buttonState: Bool {get set}
    func getRecipes() -> [Recipe]
    func loadMoreRecipes()
}

extension RecipesViewModelProtocol {
    func loadMoreRecipes() {
        // noop
    }
}
