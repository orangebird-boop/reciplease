import Foundation

extension RecipeEntity {
    func toGenericModel() -> Recipe {
        
        return Recipe( name: "", foodImage: foodImage, url: "", ingredientLines: [], totalTime: 0)
    }
    
//    func toGenericModel() -> Recipe {
//        let ingredientArray = ingredients.map {String($0)}
//
//        let time = Int(exactly: totalTime)
//
//        return Recipe(name: name, foodImage: foodImage, url: url, ingredientLines: ingredientArray, totalTime: time)
//    }
}
