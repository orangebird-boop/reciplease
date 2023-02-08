import UIKit
import CoreData

enum RecipeState {
    case isFavorite
    case isNotFavorite
}

protocol RecipeDetailsViewModelDelegate: AnyObject {
    func didToggleFavoriteStatusForRecipe(state: RecipeState)
}

class RecipeDetailsViewModel {
    
    // MARK: - Properties
    
    let coreDataManager: CoreDataManager
    var recipe: Recipe
    weak var delegate: RecipeDetailsViewModelDelegate?
    private (set) var recipeState: RecipeState = .isNotFavorite {
        didSet {
            delegate?.didToggleFavoriteStatusForRecipe(state: recipeState)
        }
    }
    
    // MARK: - Initialization
    
    init(recipe: Recipe, coreDataManager: CoreDataManager = .shared) {
        self.recipe = recipe
        self.coreDataManager = coreDataManager
        
        recipeState = .isNotFavorite
    }
    
    // MARK: - Functions
    
    func toggelFavoriteStatus(for recipe: Recipe) {
        switch recipeState {
        case .isFavorite:
            coreDataManager.deleteFavorite(name: recipe.name, url: recipe.url) { hasSucceeded in
                if hasSucceeded {
                    self.recipeState = .isNotFavorite
                }
            }
        case .isNotFavorite:
            addToFavorites(recipe: recipe)
        }
    }
    
    func addToFavorites(recipe: Recipe) {
        let ingredients = recipe.ingredientLines.joined(separator: "\n- ")
        
        guard let totalTime = recipe.totalTime else {return}
        guard let foodImage = recipe.foodImage else {return}
        
        coreDataManager.createFavorite(title: recipe.name, ingredients: ingredients, totalTime: Int32(totalTime), image: foodImage, url: recipe.url) { hasSucceeded in
            if hasSucceeded {
                self.recipeState = .isFavorite
            }
        }
    }
    
    func checkIfRecipeFavorite() {
        recipeState = coreDataManager.checkIfRecipeFavorite(name: recipe.name, url: recipe.url) ? .isFavorite : .isNotFavorite
    }
}
