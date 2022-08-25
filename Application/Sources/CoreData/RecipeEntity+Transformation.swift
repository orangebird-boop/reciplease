import Foundation

extension RecipeEntity {
	
	func toGenericModel() -> Recipe {
		Recipe(name: "", foodImage: "", url: "", ingredientLines: [], totalTime: 5) // TODO: Replace with real data
	}
}
