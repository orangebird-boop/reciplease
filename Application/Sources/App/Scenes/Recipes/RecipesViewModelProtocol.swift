import Foundation

protocol RecipesViewModelProtocol {
    func getRecipes() -> [Recipe]
    func loadMoreRecipes()
}

extension RecipesViewModelProtocol {
    func loadMoreRecipes() {
        // noop
    }
}
