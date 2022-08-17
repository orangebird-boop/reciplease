import UIKit
import CoreData

enum RecipeState {
    case isFavorite
    case isNotFavorite
}

protocol RecipeDetailsViewModelDelegate: AnyObject {
    func didToggleFavoriteStatusForREcipe(state: RecipeState)
}

class RecipeDetailsViewModel {
    
    let coreDataManager = CoreDataManager(name: "RecipeEntity")
    var recipe: Recipe
    weak var delegate: RecipeDetailsViewModelDelegate?
    var recipeState: RecipeState {
        didSet {
            delegate?.didToggleFavoriteStatusForREcipe(state: recipeState)
        }
        
    }
    init(recipe: Recipe) {
        self.recipe = recipe
        
        recipeState = .isNotFavorite
    }
    
    // ajouter aux favorites
    
    func toggelFavoriteStatus(for recipe: Recipe) {
        switch recipeState {
        case .isFavorite:
            coreDataManager.deleteFavorite(name: recipe.name, url: recipe.url)
        case .isNotFavorite:
            addToFavorites(recipe: recipe)
        }
    }
    
    func addToFavorites(recipe: Recipe) {
        let ingredients = recipe.ingredientLines.joined(separator: "\n" + "- ")
        
        guard let totalTime = recipe.totalTime else {return}
        guard let foodImage = recipe.foodImage else {return}
        
        coreDataManager.createFavorite(title: recipe.name, ingredients: ingredients, totalTime: Int64(totalTime), image: foodImage, url: recipe.url)
    }
    
    func checkIfRecipeFavorite() {
    
        recipeState = coreDataManager.checkIfRecipeFavorite(name: recipe.name, url: recipe.url) ? .isFavorite : .isNotFavorite
      
    }
    
    // Shall i create here a deleteFavorite() ? or only in FavoriteDetailsVC ?
    
}
