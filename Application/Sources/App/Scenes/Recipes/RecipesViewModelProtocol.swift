import Foundation

protocol RecipesViewModelProtocol {
    func getRecipes() -> [Recipe]
    func countRecipes() -> Int
}
