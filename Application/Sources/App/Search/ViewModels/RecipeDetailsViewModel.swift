import UIKit
import CoreData

class RecipeDetailsViewModel {
    
    let coreDataManager = CoreDataManager(name: "RecipeTestEntity")
    var recipe: Recipe?
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    // ajouter aux favorites
    
    func addToFavorites() {
        guard let label = recipe?.name else {return}
        guard let ingredients = recipe?.ingredientLines.joined(separator: "\n" + "- ") else {return}
        guard let totalTime = recipe?.totalTime else {return}
        guard let foodImage = recipe?.foodImage else {return}
        guard let url = recipe?.url else {return}
        
        coreDataManager.createFavorite(title: label, ingredients: ingredients, totalTime: Int64(totalTime), image: foodImage, url: url)
    }
    
    func checkIfRecipeFavorite() -> Bool {
        guard let name = recipe?.name else {return false}
        guard let url = recipe?.url else {return false}
        let isFavorite = coreDataManager.checkIfRecipeFavorite(name: name, url: url)
        return isFavorite
    }
    
    // Shall i create here a deleteFavorite() ? or only in FavoriteDetailsVC ?
    
}
