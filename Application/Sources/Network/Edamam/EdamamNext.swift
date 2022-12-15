//
//  EdamamNext.swift
//  Application
//
//  Created by Nora Lilla Matyassi on 04/09/2022.
//
import Foundation

// MARK: - Next
struct EdamamNext: Decodable {
    let href: String
  
}



extension EdamamNext {

    func toGenericModel() -> RecipeNext {
     
        RecipeNext(href: href)
        
    }
}
