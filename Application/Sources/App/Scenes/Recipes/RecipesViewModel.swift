import Foundation

struct RecipesViewModel: RecipesViewModelProtocol {
    
    private let recipes: [Recipe]
//    private let count: RecipeResponse.
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    func getRecipes() -> [Recipe] {
        recipes
    }
    
    func countRecipes() -> Int {
        let numberOfRecipes = recipes.count
        return numberOfRecipes
    }
    

}
