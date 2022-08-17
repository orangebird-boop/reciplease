import Foundation

class FavoritesViewModel {
    
    var recipes = [Recipe]()
    var coreDataManager = CoreDataManager(name: "RecipeEntity")
}
