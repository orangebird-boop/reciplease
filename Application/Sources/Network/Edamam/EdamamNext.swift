//
//  EdamamNext.swift
//  Application
//
//  Created by Nora Lilla Matyassi on 04/09/2022.
//
import Foundation

// MARK: - Next

enum Title: String, Codable {
    case nextPage = "Next page"
    
}

extension EdamamLink {

    func toGenericModel() -> RecipeNext {
     
        RecipeNext(href: href, title: RecipeTitle.nextPage)
        
    }
}
