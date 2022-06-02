//
//  RecipeData+CoreDataProperties.swift
//  
//
//  Created by Nora Lilla Matyassi on 01/06/2022.
//
//

import Foundation
import CoreData


extension RecipeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeData> {
        return NSFetchRequest<RecipeData>(entityName: "RecipeData")
    }

    @NSManaged public var nameDM: String?
    @NSManaged public var foodImageDM: String?
    @NSManaged public var urlDM: String?
    @NSManaged public var yieldDM: Double
    @NSManaged public var ingredientLinesDM: [String]?
    @NSManaged public var totalTimeDM: Int64

}
