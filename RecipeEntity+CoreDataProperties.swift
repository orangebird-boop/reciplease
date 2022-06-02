//
//  RecipeEntity+CoreDataProperties.swift
//  
//
//  Created by Nora Lilla Matyassi on 02/06/2022.
//
//

import Foundation
import CoreData


extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var nameAttribute: String?
    @NSManaged public var foodImageAttribute: String?
    @NSManaged public var urlAttribute: String?
    @NSManaged public var yieldAttribute: Double
    @NSManaged public var ingredientLinesAttribute: [String]?
    @NSManaged public var totalTimeAttribute: Int64

}
