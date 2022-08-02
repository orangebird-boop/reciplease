//
//  RecipeTestEntity+CoreDataProperties.swift
//  Application
//
//  Created by Nora Lilla Matyassi on 02/08/2022.
//
//

import Foundation
import CoreData


extension RecipeTestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeTestEntity> {
        return NSFetchRequest<RecipeTestEntity>(entityName: "RecipeTestEntity")
    }

    @NSManaged public var nameTest: String?

}

extension RecipeTestEntity : Identifiable {

}
