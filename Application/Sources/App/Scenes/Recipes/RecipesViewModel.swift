import Foundation

struct RecipesViewModel: RecipesViewModelProtocol {
	
	private let recipes: [Recipe]
	
	init(recipes: [Recipe]) {
		self.recipes = recipes
	}
	
	func getRecipes() -> [Recipe] {
		recipes
	}
}
