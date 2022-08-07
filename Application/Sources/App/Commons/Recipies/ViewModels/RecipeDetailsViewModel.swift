import UIKit
import CoreData

class RecipeDetailsViewModel {
    
    let corDataManager = CoreDataManager(name: "RecipeTestEntity")
    var recipe: Recipe?
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    // ajouter aux favorites
    
    func addToFavorites(){
        guard let label = recipe?.name else {return}
        guard let ingredients = recipe?.ingredientLines.joined(separator: "\n" + "- ") else {return}
        guard let totalTime = recipe?.totalTime else {return}
        guard let foodImage = recipe?.foodImage else {return}
        guard let url = recipe?.url else {return}
        
        corDataManager.createRecipe(title: label, ingredients: ingredients, totalTime: Int64(totalTime), image: foodImage, url: url)
    }
    
    private func checkIfRecipeFavorite(){
        guard let name = recipe?.name else {return}
        guard let url = recipe?.url else {return}
        let isFavorite = corDataManager.checkIfRecipeFavorite(name: name, url: url) 
    }
}
