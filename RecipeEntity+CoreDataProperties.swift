//
//  RecipeEntity+CoreDataProperties.swift
//  Application
//
//  Created by Nora Lilla Matyassi on 07/08/2022.
//
//

import Foundation
import CoreData


extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var url: String?
    @NSManaged public var foodImage: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var name: String?
    @NSManaged public var totalTime: Int64

}

extension RecipeEntity : Identifiable {

}
