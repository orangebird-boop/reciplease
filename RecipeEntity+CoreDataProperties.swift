//
//  RecipeEntity+CoreDataProperties.swift
//  Application
//
//  Created by Nora Lilla Matyassi on 16/08/2022.
//
//

import Foundation
import CoreData


extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var foodImage: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?
    @NSManaged public var totalTime: Int64
    @NSManaged public var url: String?

}

extension RecipeEntity : Identifiable {

}
