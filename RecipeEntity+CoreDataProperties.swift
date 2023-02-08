import Foundation
import CoreData


extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var recipeFoodImage: String
    @NSManaged public var recipeIngredients: String
    @NSManaged public var recipeName: String
    @NSManaged public var recipeTotalTime: Int32
    @NSManaged public var recipeUrl: String

}

extension RecipeEntity : Identifiable {

}
