import Foundation

class SearchResultViewModel {
    var recipes: [EdamamRecipe] = []
    
    init(recipes: [EdamamRecipe]) {
        self.recipes = recipes
    }
}
