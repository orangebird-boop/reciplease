import Foundation

extension RecipeEntity {
    func toGenericModel() -> Recipe {
      
        Recipe( name: recipeName, foodImage: recipeFoodImage, url: recipeUrl, ingredientLines: recipeIngredients.components(separatedBy: "\n- "), totalTime: Int(recipeTotalTime))
    }
}
