import Foundation

extension RecipeEntity {
    func toGenericModel() -> Recipe {
        Recipe(name: "ham", foodImage: foodImage, url: "", ingredientLines: [], totalTime: 10)
    }
}
