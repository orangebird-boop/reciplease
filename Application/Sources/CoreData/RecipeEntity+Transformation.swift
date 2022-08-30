import Foundation

extension RecipeEntity {
    func toGenericModel() -> Recipe {
        
        return Recipe( name: "recipeName", foodImage: recipeFoodImage, url: "recipeUrl!", ingredientLines: [], totalTime: 56)
    }
    
//    func toGenericModel() -> Recipe {
//        let ingredientArray = ingredients.map {String($0)}
//
//        let time = Int(exactly: totalTime)
//
//        return Recipe(name: recipeName, foodImage: recipeFoodImage, url: recipeUrl!, ingredientLines: recipeIngredients, totalTime: recipeTotalTime)
//    }
}
